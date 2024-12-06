import 'package:ecom_books/constants/Constants.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import 'StorageService.dart';

class ApiService extends GetxService {
   Dio dio= Dio(BaseOptions(
     baseUrl: Constants.baseUrl,
     connectTimeout: const Duration(seconds: 30),
     receiveTimeout:  const Duration(seconds: 30),
   ));
  final token = ''.obs;
 final StorageService _storageService = Get.find<StorageService>();

  Future<ApiService> init(String? token1) async {
    // if(token.isEmpty){
      if(token1 !=null && token1!=''){
        token.value=token1;
      }else{
        final token2 = await _storageService.read(Constants.authTokenKey);
        token.value=token2??'';
      }
    // }
    print("_token :${token}");
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (token.isNotEmpty) {
          print("token not empty");
          options.headers['Authorization'] = 'Bearer ${token.value}';
        }
        return handler.next(options);
      },
      onError: (DioError e, handler) {
        // Handle errors globally
        return handler.next(e);
      },
    ));
    print('--------------------');
    print(dio.options.baseUrl);
    print(dio.options.headers.toString());
    print(dio.interceptors);
    print('--------------------');
    return this;
  }

  void setToken(String token1) {
    print("setToken ${token1}");
    token.value = token1;
    init(token1);
  }
  Future postRequestTemp(String endpoint,data,token) async {
    final Dio dio = Dio();
    try {
    dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await dio.post(Constants.baseUrl+endpoint, data: data);
    return response;
  } catch (e) {
   onError(e);
   }
  }

   Future onError(e){
     if (e is DioError) {
       if (e.response != null) {
         final errorData = e.response!.data;
         if (errorData is Map<String, dynamic>) {
           if (errorData.containsKey('errors') && errorData['errors'] is List && errorData['errors'].isNotEmpty) {
             throw Exception(errorData['errors'][0]['message']);
           } else if (errorData.containsKey('message')) {
             throw Exception(errorData['message']);
           } else {
             throw Exception('Unexpected error structure: ${errorData.toString()}');
           }
         } else {
           throw Exception(e.message);
         }
       } else {
         throw Exception(e.message);
       }
     }
     throw Exception('Unexpected error occurred');
   }

  Future getRequest(String endpoint) async {
    try {
      final response = await dio.get(endpoint);
      return response;
    } catch (e) {
      onError(e);
    }
  }

  Future postRequest(String endpoint,data) async {

    try {
      final response = await dio.post(endpoint,data: data);
      return response;
    } catch (e) {
      onError(e);
    }
  }
   Future putRequest(String endpoint,data) async {
     print(dio.options.headers.toString());
     try {
       final response = await dio.put(endpoint,data: data);
       return response;
     } catch (e) {
       onError(e);
     }
   }
   Future deleteRequest(String endpoint) async {
     try {
       final response = await dio.delete(endpoint);
       return response;
     } catch (e) {
       onError(e);
     }
   }

// Add other HTTP methods here (post, put, delete, etc.)
}