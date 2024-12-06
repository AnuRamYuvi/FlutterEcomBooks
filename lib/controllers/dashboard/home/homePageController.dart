import 'package:ecom_books/constants/AppImages.dart';
import 'package:ecom_books/constants/size_config.dart';
import 'package:ecom_books/controllers/dashboard/myOrders/myOrderController.dart';
import 'package:ecom_books/views/dashboard/home/Address/mapPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../constants/AppColors.dart';
import '../../../constants/Constants.dart';
import '../../../models/dashboard/home/homeModel.dart';
import '../../../services/ApiService.dart';
import '../../../services/StorageService.dart';
import '../../../views/dashboard/home/Address/savedAddress.dart';
import '../../../views/Widgets/customAlertDialog.dart';
import '../../../views/Widgets/customDialog.dart';
import '../../../views/dashboard/widget/horizontalDashLine.dart';
import '../categories/product/productController.dart';
import '../myAccount/myAccountController.dart';
import '../myOrders/myCartPageController.dart';
import '../widgetController/customBottomBarController.dart';

class HomePageController extends GetxController{
  final ApiService apiService = Get.find<ApiService>();
  final StorageService storageService = Get.find<StorageService>();
  HomeModel? homeModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHomePageInfo();
  }
  locationDialog (){
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: CustomDialog(
          imageUrl: AppImages.locationImg,
          title:  'delivery_location'.tr,
          content: 'for_delivering_purpose_we_need'.tr,
          onConfirm: () {
            Get.to(MapScreen());
            // Get.to(AddAddress());
          },
          onCancel: () {
                // if(customerInfo!=null && customerInfo!.outletPolygon !=null && customerInfo!.outletPolygon!.id !=null ){
                //   Get.back();
                // }
          },
          onCloseBtn: false,
          orderId: '',
          confirmText:'select_your_location'.tr,
        ),
      ),
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: false,
      arguments: {'data': 'some data'},
    );
  }

  shopClose(String open,bool itsDoubleBack) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
         return false;
        },
        child: Dialog(
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            // backgroundColor: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap:(){
                            Get.back();
                            if(itsDoubleBack){
                              Get.back();
                            }
                          },
                          child: const Icon(Icons.highlight_remove,color: Colors.black,size: 25,))
                    ],),
                  Image.asset(AppImages.storeClosed,height: 150,),
                  Text(
                    'our_stores_are'.tr,
                    style: const TextStyle(fontFamily:'inter',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'closed_now'.tr,
                    style: const TextStyle(fontFamily:'inter',
                      fontSize: 18.0,color: AppColors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("We will reopen at ${open}",textAlign: TextAlign.center,style: TextStyle(fontFamily:'inter',color: AppColors.grayColor,fontSize: 13),),
                  SizedBox(height: 10.0),

                ],
              ),
            ),
          ),
        ),
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: false,
      arguments: {'data': 'some data'},
    );
  }

  bool isShopOpen(String opensAt, String closesAt) {
    try{
    // Define a date format that matches the time strings
    DateFormat timeFormat = DateFormat('HH:mm:ss');

    // Parse the opens_at and closed_at times
    DateTime opensAtTime = timeFormat.parse(opensAt);
    DateTime closesAtTime = timeFormat.parse(closesAt);

    // Get the current time
    DateTime now = DateTime.now();
    DateTime currentTime = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);

    // Adjust closesAtTime to next day if it is before opensAtTime
    if (closesAtTime.isBefore(opensAtTime)) {
      closesAtTime = closesAtTime.add(Duration(days: 1));
    }
    // Check if the current time is between opensAtTime and closesAtTime
    return currentTime.isAfter(opensAtTime) && currentTime.isBefore(closesAtTime);

    }catch(e){
      print(e.toString());
      return true;
      }
    }

  void checkShopClose(bool itsDoubleBack) async {
    try {
      final response = await apiService.getRequest('customers/info');
      if(response != null){
        CustomerInfo customerInfo = CustomerInfo.fromJson(response.data);
        if(customerInfo!=null && customerInfo?.outletPolygon !=null && customerInfo!.outletPolygon!.id!=null){
          if(customerInfo.outletPolygon!.closedAt!=null && customerInfo.outletPolygon!.opensAt!=null){
            if(isShopOpen(customerInfo.outletPolygon!.opensAt!,customerInfo.outletPolygon!.closedAt!)){
              DateTime time = DateFormat("HH:mm:ss").parse(customerInfo.outletPolygon!.opensAt!);
              String formattedTime = DateFormat("hh:mm a").format(time);
              shopClose(formattedTime,itsDoubleBack);
              if (Get.isRegistered<MyCartPageController>()) {
                Get.find<MyCartPageController>().shopCloseTimeCheck();
              }
            }
          }
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  // getCustomerInfo() async {
  //   print('getCustomerInfo');
  //   try {
  //     final response = await apiService.getRequest('customers/info');
  //     print(response);
  //
  //     if(response != null){
  //       // print(jsonDecode(response));
  //       customerInfo = CustomerInfo.fromJson(response.data);
  //       update();
  //       if(customerInfo!=null && customerInfo?.outletPolygon !=null && customerInfo!.outletPolygon!.id!=null ){
  //         outletId=customerInfo!.outletPolygon!.id!;
  //         getHomePageInfo(customerInfo!.outletPolygon!.id,customerInfo!.customersMobile);
  //       }else{
  //         locationDialog();
  //       }
  //     }
  //   } catch (e) {
  //     print('Error: ${e.toString()}');
  //     Fluttertoast.showToast(
  //         msg: e.toString() ,
  //         toastLength: Toast.LENGTH_SHORT);
  //     locationDialog();
  //   }
  // }

  void getHomePageInfo() async {
    try {
      final response = await apiService.getRequest('dashboard');
      if(response !=null){
        homeModel = HomeModel.fromJson(response.data);
        update();
        if(homeModel==null||homeModel!.customerInfo==null ||homeModel!.customerInfo!.addressLines==null || homeModel!.customerInfo!.addressLines!.isEmpty){
          locationDialog();
        }else{
          saveData(homeModel!.customerInfo!.customersMobile);
        }
      }else{
        locationDialog();
      }
    } catch (e) {
      // locationDialog();
      print('Error: $e');
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
      // data = 'Failed to load data';
    }
  }

  void saveData(String? mobile) {
    try {
      print(mobile.toString());
      storageService.write(Constants.phoneNo, mobile.toString());
      if (Get.isRegistered<MyOrderController>()) {
        Get.find<MyOrderController>().pagingController.refresh();
      }
      if (Get.isRegistered<MyCartPageController>()) {
        Get.find<MyCartPageController>().onRefreshCartAddress();
      }
      if (Get.isRegistered<MyAccountController>()) {
        Get.find<MyAccountController>().getAccountData(homeModel!.customerInfo);
      }
      if (Get.isRegistered<CustomBottomBarController>()) {
        Get.find<CustomBottomBarController>().loadCartData();
      }
      if (Get.isRegistered<ProductController>()) {
        Get.find<ProductController>().refreshPagingController();
      }
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
      // data = 'Failed to load data';
    }
  }

  void setDefaultAddressDialog(int id,addressLines){
    Get.dialog(
      CustomAlertDialog(
        title: 'confirmation'.tr,
        content: 'do_you_want_to_set_this_address_as_default'.tr,
        onConfirm: () {
          Get.back();
          setDefaultAddress(id,addressLines);
          // Handle confirm action
        },
        onCancel: () {
          Get.back();
          // Handle cancel action
        },
        onConfirmText: 'Set as default',
      ),
    );
  }

  void setDefaultAddress(int addressId,addressLines) async {
    try {
      var postData = {
        'address_line1': addressLines.addressLine1,
        'address_line2': addressLines.addressLine2,
        'address_line3': addressLines.addressLine3,
        'address_type': addressLines.addressTypeId,
        'longitude': addressLines.longitude,
        'latitude': addressLines.latitude,
        'city': addressLines.city,
        'state': addressLines.state,
        'country': addressLines.country,
        'pincode': addressLines.pincode,
        'is_default': true,
        'is_active': addressLines.isActive,
      };
      print(postData);
      print('customers/address/$addressId');
      final response = await apiService.putRequest('customers/address/$addressId',postData);
      if(response != null){
        Get.back();
        // print(jsonDecode(response));
        getHomePageInfo();
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  void openAddressBottomSheet(){
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
           Container(
              decoration: const BoxDecoration(
                color: AppColors.appLiteColor1,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on,color: AppColors.appColor,size: 30,),
                        const SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('please_search_for_your'.tr,style: TextStyle(color: AppColors.appColor,fontWeight: FontWeight.bold,fontSize: 13),),
                            SizedBox(width: SizeConfig.screenWidth!/1.45,
                                child: Text('accurate_location'.tr,style: TextStyle(color: AppColors.grayColor,fontSize: 10),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                          ],),
                      ],
                    ),
                    IconButton(onPressed: (){
                      Get.back();
                    },
                        icon: const Icon(Icons.close,color: AppColors.black,size: 20,))
                  ],),
              ),
            ),
           Padding(
             padding:  EdgeInsets.all(15.0),
             child: Column(
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                   Text('select_from_saved_address'.tr,style: TextStyle(fontWeight:FontWeight.bold,color: AppColors.grayColor,fontSize: 12),),
                   InkWell(
                     onTap: (){
                      Get.back();
                      Get.to(SavedAddress());
                     },
                     child: const Row(
                       children: [
                         Text('See All',style: TextStyle(fontWeight:FontWeight.bold,color: AppColors.appColor,fontSize: 10),),
                         Icon(Icons.keyboard_arrow_right_rounded,color: AppColors.appColor,size: 20,)
                       ],
                     ),
                   ),
                 ],),
                 const SizedBox(height: 15,),

                 homeModel!=null && homeModel!.customerInfo!=null && homeModel!.customerInfo!.addressLines!=null && homeModel!.customerInfo!.addressLines!.isNotEmpty ?
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     const CircleAvatar(
                         backgroundColor: AppColors.appBgLiteColor, // Background color
                         radius: 15.0,
                         child: Icon(Icons.location_on,color: AppColors.appColor,size: 20,)),

                     const SizedBox(width: 10,),
                     Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(
                           width: SizeConfig.screenWidth!/1.3,
                           child: Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(homeModel!.customerInfo!.addressLines![0].addressType!,style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                               homeModel!.customerInfo!.addressLines![0].isDefault=="true"?Container(
                                 decoration: BoxDecoration(
                                     color: AppColors.appLiteColor1,
                                     borderRadius: BorderRadius.circular(5)
                                 ),
                                 child:  Padding(
                                   padding: const EdgeInsets.only(left: 8.0,right: 8,top: 5,bottom: 5),
                                   child: Row(
                                     children: [
                                       const Icon(
                                         Icons.circle,
                                         size: 8.0, // Adjust the size of the dot
                                         color: AppColors.appColor, // Adjust the color of the dot
                                       ),
                                       const SizedBox(width: 5,),
                                       Text('default_txt'.tr,style: const TextStyle(fontSize: 8,color: AppColors.appColor,fontWeight: FontWeight.bold),)
                                     ],),
                                 ),
                               ):Container()
                             ],
                           ),
                         ),
                         const SizedBox(height: 5,),
                         SizedBox(
                             width: SizeConfig.screenWidth!/1.3,
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text('${homeModel!.customerInfo!.addressLines![0].addressLine1!}, ${homeModel!.customerInfo!.addressLines![0].addressLine2!}, ${homeModel!.customerInfo!.addressLines![0].addressLine3!} - ${homeModel!.customerInfo!.addressLines![0].pincode!}',style: TextStyle(color: AppColors.grayColor,fontSize: 13),),
                                 homeModel!.customerInfo!.addressLines![0].alternativeMobile!=null &&homeModel!.customerInfo!.addressLines![0].alternativeMobile!.trim()!=''?
                                 Padding(
                                   padding: const EdgeInsets.only(top: 5.0),
                                   child: Text('${'alternative_number'.tr}${homeModel!.customerInfo!.addressLines![0].alternativeMobile!}',style: TextStyle(color: AppColors.grayColor,fontSize: 13),),
                                 ):Container(),
                               ],
                             )),
                       ],),
                   ],
                 ):Container(),
                 const SizedBox(height: 10,),
                 const DashedHorizontalDivider(color: AppColors.appBgLiteColor,width: double.infinity,dashWidth: 5,dashSpace: 8,),
                 homeModel!=null && homeModel!.customerInfo!=null && homeModel!.customerInfo!.addressLines!=null && homeModel!.customerInfo!.addressLines!.isNotEmpty && homeModel!.customerInfo!.addressLines!.length>1?
                 InkWell(
                   onTap: (){
                     setDefaultAddressDialog(homeModel!.customerInfo!.addressLines![1].id!,homeModel!.customerInfo!.addressLines![1]);
                   },
                   child: Column(
                     children: [
                       const SizedBox(height: 10,),
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           const CircleAvatar(
                               backgroundColor: AppColors.appBgLiteColor, // Background color
                               radius: 15.0,
                               child: Icon(Icons.location_on,color: AppColors.appColor,size: 20,)),

                           const SizedBox(width: 10,),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               SizedBox(
                                 width: SizeConfig.screenWidth!/1.3,
                                 child: Row(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text(homeModel!.customerInfo!.addressLines![1].addressType!,style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                                     homeModel!.customerInfo!.addressLines![1].isDefault=="true"?Container(
                                       decoration: BoxDecoration(
                                           color: AppColors.appLiteColor1,
                                           borderRadius: BorderRadius.circular(5)
                                       ),
                                       child:  Padding(
                                         padding: const EdgeInsets.only(left: 8.0,right: 8,top: 5,bottom: 5),
                                         child: Row(
                                           children: [
                                             const Icon(
                                               Icons.circle,
                                               size: 8.0, // Adjust the size of the dot
                                               color: AppColors.appColor, // Adjust the color of the dot
                                             ),
                                             const SizedBox(width: 5,),
                                             Text('default_txt'.tr,style: const TextStyle(fontSize: 8,color: AppColors.appColor,fontWeight: FontWeight.bold),)
                                           ],),
                                       ),
                                     ):Container()
                                   ],
                                 ),
                               ),
                               const SizedBox(height: 5,),
                               SizedBox(
                                   width: SizeConfig.screenWidth!/1.3,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text('${homeModel!.customerInfo!.addressLines![1].addressLine1!}, ${homeModel!.customerInfo!.addressLines![1].addressLine2!}, ${homeModel!.customerInfo!.addressLines![1].addressLine3!} - ${homeModel!.customerInfo!.addressLines![1].pincode!}',style: TextStyle(color: AppColors.grayColor,fontSize: 13),),
                                       homeModel!.customerInfo!.addressLines![1].alternativeMobile!=null &&homeModel!.customerInfo!.addressLines![1].alternativeMobile!.trim()!=''?
                                       Padding(
                                         padding: const EdgeInsets.only(top: 5.0),
                                         child: Text('${'alternative_number'.tr}${homeModel!.customerInfo!.addressLines![1].alternativeMobile!}',style: TextStyle(color: AppColors.grayColor,fontSize: 13),),
                                       ):Container(),
                                     ],
                                   )),
                             ],),
                         ],
                       ),
                       SizedBox(height: 10,),
                       const DashedHorizontalDivider(color: AppColors.appBgLiteColor,width: double.infinity,dashWidth: 5,dashSpace: 8,),
                     ],
                   ),
                 ):Container(),
                 SizedBox(height: 10,),
                 
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     const DashedHorizontalDivider(color: AppColors.appBgLiteColor,width: 60,dashWidth: 5,dashSpace: 0,),
                     const SizedBox(width: 10,),
                     Text('or'.tr,style: const TextStyle(color: AppColors.grayColor,fontSize: 14,),),
                     const SizedBox(width: 10,),
                     const DashedHorizontalDivider(color: AppColors.appBgLiteColor,width: 60,dashWidth: 5,dashSpace: 0,),

                   ],),
                 SizedBox(height: 10,),

                 InkWell(
                   onTap: (){
                     Get.back();
                     Get.to(SavedAddress());
                   },
                   child: Container(
                     height: 45,
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: const BorderRadius.all(Radius.circular(8)),
                       border: Border.all(color: AppColors.appBgLiteColor,width: 1),
                     ),
                     child:  Padding(
                       padding: const EdgeInsets.only(left: 5.0,right: 5),
                       child: Row(
                         children: [
                           const Icon(Icons.search,color: AppColors.black,),
                           const SizedBox(width: 5,),
                           Text('search_location_manually'.tr)
                         ],),
                     ),
                   ),
                 ),
               ],
             ),
           ),
              SizedBox(height: 10,)
        ]),
        ),
      ignoreSafeArea: false
    );
  }


}