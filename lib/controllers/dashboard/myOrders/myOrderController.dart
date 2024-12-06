import 'package:ecom_books/models/dashboard/myOrders/myOrdersModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../../services/ApiService.dart';

class MyOrderController extends GetxController{
  late PagingController<int, Data> pagingController = PagingController(firstPageKey: 1);
  final ApiService apiService = Get.find<ApiService>();
  int pageSize=10;

  String formatDateTime(String dateTimeString) {
    try {
      // Parse the date and time string
      DateTime dateTime = DateTime.parse(dateTimeString);

      // Convert to local time
      DateTime localDateTime = dateTime.toLocal();

      // Create a DateFormat
      DateFormat formatter = DateFormat('dd-MM-yyyy @ h:mma');

      // Format the date
      String formatted = formatter.format(localDateTime);
      return formatted;
    }catch(e){
      return '';
    }
  }
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pagingController.refresh();
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }


  void fetchPage(int pageKey) async {
    try {
      final response = await apiService.getRequest('orders/$pageSize/$pageKey');
      if(response != null){
        MyOrdersModel newData = MyOrdersModel.fromJson(response.data);
        if (newData!=null) {
          final isLastPage = newData.data!.length < pageSize;
          if (isLastPage) {
            pagingController.appendLastPage(newData.data!);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(newData.data!, nextPageKey);
          }
          update();
        }
      }
    } catch (e) {
      pagingController.appendPage([], pageKey);

      print('Error: ${e.toString()}');
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
    }
    // final newData = fetchYourData(pageKey);
  }
  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }


}