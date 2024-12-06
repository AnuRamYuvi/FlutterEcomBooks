import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/dashboard/myOrders/orderDetails.dart';
import '../../../services/ApiService.dart';
import '../categories/product/productController.dart';

class OrderDetailsController extends GetxController{
  final ApiService apiService = Get.find<ApiService>();
  OrderDetails? orderDetails;
  String orderConfirmedDate='';
  String orderProcessingDate='';
  String orderInvoiceDate='';
  String orderShippedDate='';
  String orderDeliveredDate='';

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

  void loadOrderData(int? orderId) async{
    try {
      final response = await apiService.getRequest('orders/$orderId');
      print('orders/$orderId');
      if(response != null){
        orderDetails = OrderDetails.fromJson(response.data);
        getDate(orderDetails);
        update();
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
    }

  }

  void getDate(OrderDetails? orderDetails) {
    if(orderDetails!=null){
      try {
        orderConfirmedDate = formatDateTime(orderDetails.createdAt!);
        if (orderDetails.orderStatusLog != null && orderDetails.orderStatusLog!.isNotEmpty) {
          for (int i = 0; i < orderDetails.orderStatusLog!.length; i++) {
            if (orderDetails.orderStatusLog![i].orderStatus == 1) {
              orderProcessingDate = formatDateTime(orderDetails.orderStatusLog![i].createdAt!);
            } else if (orderDetails.orderStatusLog![i].orderStatus == 2) {
              orderInvoiceDate = formatDateTime(orderDetails.orderStatusLog![i].createdAt!);
            } else if (orderDetails.orderStatusLog![i].orderStatus == 3) {
              orderShippedDate = formatDateTime(orderDetails.orderStatusLog![i].createdAt!);
            } else if (orderDetails.orderStatusLog![i].orderStatus == 4) {
              orderDeliveredDate = formatDateTime(orderDetails.orderStatusLog![i].createdAt!);
            }
          }
        }
      }catch(e){
        print('Error: ${e.toString()}');
        Fluttertoast.showToast(
            msg: e.toString() ,
            toastLength: Toast.LENGTH_SHORT);
      }
    }
    update();
  }


}