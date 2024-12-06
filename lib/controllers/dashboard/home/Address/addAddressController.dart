import 'package:ecom_books/controllers/dashboard/home/Address/savedAddressController.dart';
import 'package:ecom_books/models/dashboard/home/address/country.dart';
import 'package:ecom_books/models/dashboard/home/address/state.dart';
import 'package:ecom_books/views/dashboard/mainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';

import '../../../../models/dashboard/home/address/addressType.dart';
import '../../../../models/dashboard/home/address/city.dart';
import '../../../../models/dashboard/home/homeModel.dart';
import '../../../../services/ApiService.dart';
import '../../widgetController/dialogLoaderController.dart';
import '../homePageController.dart';

class AddAddressController extends GetxController{
  final DialogLoaderController dialogLoaderController = Get.find<DialogLoaderController>();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityStateController = TextEditingController();
  List<Country> countries =[];
  List<StateModel> states =[];
  List<CityModel> city =[];
  AddressType? addressType ;
  bool isDefaultChecked=false;
  RxInt countryId=0.obs;
  RxInt statesId=0.obs;
  RxInt cityId=0.obs;
  RxInt type=0.obs;
  // final ApiService apiService = ApiService();
  final ApiService apiService = Get.find<ApiService>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // apiService.init("").then((_) {
      getCountry();
      getType();
    // });

  }

  void getCountry() async {
    try {
      final response = await apiService.getRequest('countries');
      print(response);
      if(response != null){
        // print(jsonDecode(response));
        countries = (response.data as List).map((data) => Country.fromJson(data)).toList();
        update();
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
    }
  }
  void getState(countryId) async {
   try{
    var postData = {'country_id': countryId};
    print(postData);
    final response = await apiService.postRequest('states',postData);
      print(response);
      if(response != null){
        // print(jsonDecode(response));
        states = (response.data as List).map((data) => StateModel.fromJson(data)).toList();
        print('states ${states.length}');
        update();
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
    }
  }
  void getCity(stateId) async {
    try{
      var postData = {'state_id': stateId};

      final response = await apiService.postRequest('cities',postData);
      print(response);
      if(response != null){
        // print(jsonDecode(response));
        city = (response.data as List).map((data) => CityModel.fromJson(data)).toList();
        update();
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
    }
  }
  void getType()async{
    try {
      final response = await apiService.getRequest('address/10/1');
      print(response);
      if(response != null){
        // print(jsonDecode(response));
        addressType = AddressType.fromJson(response.data);
        update();
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
    }
  }
  @override
  void onClose() {
    // TODO: implement onClose
    countries.clear();
    states.clear();
    city.clear();
    addressType = null;
    isDefaultChecked = false;
    countryId.value = 0;
    statesId.value = 0;
    cityId.value = 0;
    type.value = 0;
    super.onClose();
  }

  void onAddAddress(lat,lug) async {
    dialogLoaderController.showLoader();
    try {
      var postData = {
        'address_line1': addressController.text,
        'address_line2': landmarkController.text,
        'address_line3': cityStateController.text,
        'alternative_mobile': mobileController.text,
        'address_type':type.value,
        'state': statesId.value,
        'city': cityId.value,
        'country': countryId.value,
        'pincode': pinCodeController.text,
        'is_default': true,
        'latitude': lat,
        'longitude': lug
      };
      print("&&&&&&&&&&&&&&&&&");
      print(postData);
      final response = await apiService.postRequest('customers/address',postData);
      print(response);
      if(response != null){
        if (Get.isRegistered<HomePageController>()) {
            Get.find<HomePageController>().getHomePageInfo();
        }
        if (Get.isRegistered<SavedAddressController>()) {
          Get.find<SavedAddressController>().getAddress();
        }
        dialogLoaderController.hideLoader();
        Get.offAll(()=>MainScreen());
        // bool itsFirstAddress=false;
        // if (Get.isRegistered<SavedAddressController>()) {
        //   Get.find<SavedAddressController>().getAddress();
        // }
        // if (Get.isRegistered<HomePageController>()) {
        //   HomeModel? homeModel= Get.find<HomePageController>().homeModel;
        //   Get.find<HomePageController>().getHomePageInfo();
        //   if(homeModel==null||homeModel.customerInfo==null ||homeModel.customerInfo!.addressLines==null || homeModel.customerInfo!.addressLines!.isEmpty){
        //     itsFirstAddress=true;
        //     Get.offAll(MainScreen());
        //   }
        // }
        //
        // if(!itsFirstAddress) {
        //   Get.back();
        //   Get.back();
        //   Get.back();
        // }
       // Get.offAll(MainScreen());
      }
    } catch (e) {
      dialogLoaderController.hideLoader();
      print('Error: ${e.toString()}');
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
    }
  }
}