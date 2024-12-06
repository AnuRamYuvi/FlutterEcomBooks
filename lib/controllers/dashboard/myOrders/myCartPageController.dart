import 'package:ecom_books/constants/AppStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../constants/AppColors.dart';
import '../../../constants/AppImages.dart';
import '../../../constants/Constants.dart';
import '../../../models/dashboard/categories/cartModel.dart';
import '../../../models/dashboard/home/homeModel.dart';
import '../../../models/dashboard/myOrders/placeOrder.dart';
import '../../../services/ApiService.dart';
import '../../../services/StorageService.dart';
import '../../../views/Widgets/customAlertDialog.dart';
import '../../../views/Widgets/customDialog.dart';
import '../../../views/dashboard/mainScreen.dart';
import '../categories/product/productController.dart';
import '../home/homePageController.dart';
import '../widgetController/customBottomBarController.dart';
import '../widgetController/dialogLoaderController.dart';
import 'myOrderController.dart';

class MyCartPageController extends GetxController{
  final ApiService apiService = Get.find<ApiService>();
  final StorageService storageService = Get.find<StorageService>();
  Razorpay razorpay = Razorpay();
  final CustomBottomBarController customBottomBarController = Get.find<CustomBottomBarController>();
  final HomePageController homePageController = Get.find<HomePageController>();
  final DialogLoaderController dialogLoaderController = Get.find<DialogLoaderController>();

  CartModel? cartData;
  bool redeemChecked = false;
  String? selectedOption='online';
  int addressId=0;
  CustomerInfo? customerInfo;
  bool shopCloseTime=false;
  String shopOpenTime='';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }
  void shopCloseTimeCheck() {
    shopCloseTime=true;
    update();
  }

  void checkShopClose() async {
    try {
      homePageController.checkShopClose(true);
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  void openCheckout(double amount,String phone,String email) {
    // const String logoUrl = 'https://your-logo-url.com/logo.png'; // Replace with your actual logo URL
    var options = {
      'key': Constants.razorPayKey,
      'amount': amount * 100, // Convert amount to paise
      'name': AppStrings.appName,
      'description': 'Payment for your order',
      // 'image': logoUrl,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': phone,
        'email': email
      },
      'theme': {
        'color': '#${AppColors.appColor.value.toRadixString(16).substring(2)}' // Hex code for the desired color
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar('Success', 'Payment successful: ${response.paymentId}');
    placeOrder(response.paymentId,1);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar('Error', 'Payment error: ${response.code} - ${response.message}');
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar('External Wallet', 'External wallet selected: ${response.walletName}');
  }

  void onLoadCartItems() async {
    dialogLoaderController.showLoader();
    try{
      final cartResponse = await apiService.getRequest('cart');
      dialogLoaderController.hideLoader();
      if(cartResponse!=null) {
        customerInfo = homePageController.homeModel!.customerInfo;
        cartData = CartModel.fromJson(cartResponse.data);
        update();
      }
    }catch(e){
      dialogLoaderController.hideLoader();
      print('onLoadCartItems ${e.toString()}');
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  void postCart(String? productCode, int? unitsId, int qty,String mode) async {
    dialogLoaderController.showLoader();
    try{

      var postData = {
        'products_code':productCode,
        'units_id':unitsId,
        'cart_quantity':qty,
        'mode':mode,
      };
      print(postData);
      final response = await apiService.postRequest('cart',postData);
      print(response);
      dialogLoaderController.hideLoader();
      if(response != null){
        if(response.data['success']=='true'){
          onLoadCartItems();
          onRefreshData();
        }
      }
    } catch (e) {
      dialogLoaderController.hideLoader();
      print('Error: ${e.toString()}');
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  onRefreshData(){
    customBottomBarController.loadCartData();
  }

  void removeAllDialog(){
    Get.dialog(
      CustomAlertDialog(
        title: 'confirmation'.tr,
        content: 'do_you_want_to_clear_cart'.tr,
        onConfirm: () {
          Get.back();
          removeAll();
          // Handle confirm action
        },
        onCancel: () {
          Get.back();
          // Handle cancel action
        },
        onConfirmText: 'Clear',
      ),
    );
  }

  void removeAll() async {
    dialogLoaderController.showLoader();
    try{
    final removeAllResponse = await apiService.getRequest('cart/clear');
    dialogLoaderController.hideLoader();
    if(removeAllResponse !=null) {
      if(removeAllResponse.data['success']=='true'){
        onLoadCartItems();
        onRefreshData();
      }
    }
   }catch(e){
      dialogLoaderController.hideLoader();
        print('onLoadCartItems ${e.toString()}');
        Fluttertoast.showToast(
        msg: e.toString() ,
        toastLength: Toast.LENGTH_SHORT);
     }
  }

  void confirmOrderDialog(double amount,String? phone,String? email,int? addressID){
      checkShopClose();
      if(!shopCloseTime) {
        addressId = addressID ?? 0;
        Get.dialog(
          CustomAlertDialog(
            title: 'confirmation'.tr,
            content: 'confirmation_msg'.tr,
            onConfirm: () {
              Get.back();
              if (!shopCloseTime) {
                if (selectedOption == 'online') {
                  openCheckout(amount, phone ?? '', email ?? '');
                } else {
                  placeOrder(null, 2);
                }
              }
            },
            onCancel: () {
              Get.back();
              // Handle cancel action
            },
            onConfirmText: 'Proceed',
          ),
        );
      }
  }

  void placeOrder(String? paymentId,int payMode) async {
    dialogLoaderController.showLoader();
    try{
      var postData = {
        'address_id':addressId,
        'order_mode':payMode,
        'order_type':1,
        'orders_transactions_id':paymentId,
      };
      print(postData);
      final response = await apiService.postRequest('orders/place',postData);
      print(response);
      if(response != null){
        dialogLoaderController.hideLoader();
        PlaceOrder placeOrder= PlaceOrder.fromJson(response.data);
        if(placeOrder.success!){
          successDialog(placeOrder.message,placeOrder.orderNumber);
          // onLoadCartItems();
          cartData!.cartLines=[];
          update();
          onRefreshData();
          if (Get.isRegistered<MyOrderController>()) {
            Get.find<MyOrderController>().pagingController.refresh();
          }
        }
      }
    } catch (e) {
      dialogLoaderController.hideLoader();
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  void onLoyaltyApply(bool? isChecked) async {
    dialogLoaderController.showLoader();
    try{
      var postData = {
        'is_apply_loyalty':isChecked,
      };
      print(postData);
      final response = await apiService.postRequest('cart/loyaltyapply',postData);
      print(response);
      if(response != null){
        dialogLoaderController.hideLoader();
        if(response.data!=null && response.data['success']){
          // redeemChecked = isChecked!;
          onLoadCartItems();
        }
      }
    } catch (e) {
      dialogLoaderController.hideLoader();
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  void successDialog(String? message, String? orderNumber) {
    Get.dialog(
      CustomDialog(
        imageUrl: AppImages.payAnimation,
        title:  'payment_completed'.tr,
        content: 'payment_success_msg'.tr,
        orderId: '#$orderNumber',
        confirmText:'Go to Home',
        onConfirm: () {
          Get.back();
          Get.offAll(()=>MainScreen());
        },
        onCancel: () {
        },
        onCloseBtn:false,
      ),
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      arguments: {'data': 'some data'},
    );
  }

  void openBottomSheet() {
    checkShopClose();
    Get.bottomSheet(
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: GetBuilder<MyCartPageController>(
              builder: (controller) {
                return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 15, bottom: 10, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('select_payment_mode'.tr,
                              style: const TextStyle(color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),),
                            IconButton(onPressed: () {
                              Get.back();
                            }, icon: const Icon(Icons.close, color: AppColors.black,
                              size: 25,))
                          ],
                        ),
                      ),
                      const Divider(
                        color: AppColors.liteGray, height: 1, thickness: 1,),

                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: controller
                                  .selectedOption == 'online' ? AppColors
                                  .appColor : AppColors.appBgLiteColor,
                                  width: 1)
                          ),
                          child: InkWell(
                            onTap: () {
                              controller.selectedOption = 'online';
                              controller.update();
                              Get.back();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SvgPicture.asset(
                                          AppImages.online,
                                          width: 40, // Adjust width as needed
                                          height: 40, // Adjust height as needed
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text('online'.tr,
                                            style: const TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),),
                                          const SizedBox(height: 5,),
                                          Text('credit_card_debit_card_net_banking_upi'.tr,
                                            style: const TextStyle(
                                                color: AppColors.grayColor,
                                                fontSize: 10),),
                                        ],)
                                    ],),
                                  Radio<String>(
                                    value: 'online',
                                    groupValue: controller.selectedOption,
                                    onChanged: (String? value) {
                                      controller.selectedOption = value;
                                      controller.update();
                                      Get.back();
                                    },
                                  ),
                                ],),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, bottom: 15),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: controller
                                  .selectedOption == 'cod'
                                  ? AppColors.appColor
                                  : AppColors.appBgLiteColor, width: 1)
                          ),
                          child: InkWell(
                            onTap: () {
                              controller.selectedOption = 'cod';
                              controller.update();
                              Get.back();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: SvgPicture.asset(
                                          AppImages.cod,
                                          width: 40, // Adjust width as needed
                                          height: 40, // Adjust height as needed
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text('cod'.tr, style: const TextStyle(
                                              color: AppColors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),),
                                          const SizedBox(height: 5,),
                                          Text('pay_cash_at_the_time_of_delivery'.tr,
                                            style: const TextStyle(
                                                color: AppColors.grayColor,
                                                fontSize: 10),),

                                        ],)
                                    ],),
                                  Radio<String>(
                                    value: 'cod',
                                    groupValue: controller.selectedOption,
                                    onChanged: (String? value) {
                                      controller.selectedOption = value;
                                      controller.update();
                                      Get.back();
                                    },
                                  ),
                                ],),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,)
                    ]
                );
              }
          ),
        ),
        isScrollControlled: true,
        ignoreSafeArea: false
      );
  }

  void onRefreshCartAddress(){
    shopCloseTime=false;
    update();
    onLoadCartItems();
    checkShopClose();
  }




}