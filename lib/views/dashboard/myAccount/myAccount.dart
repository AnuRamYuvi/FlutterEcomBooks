import 'package:ecom_books/constants/AppColors.dart';
import 'package:ecom_books/constants/AppStrings.dart';
import 'package:ecom_books/controllers/dashboard/myAccount/myAccountController.dart';
import 'package:ecom_books/views/Widgets/header.dart';
import 'package:ecom_books/views/dashboard/myAccount/webViewPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import '../../register.dart';
import '../home/Address/savedAddress.dart';
import '../widget/horizontalDashLine.dart';

class MyAccount extends StatelessWidget {
   MyAccount({super.key});
  final MyAccountController myAccountController = Get.put(MyAccountController());
  @override
  Widget build(BuildContext context) {

    return GetBuilder<MyAccountController>(
      // initState: (_){myAccountController.getAccountData();},
      builder: (controller) {
        String customersName='';
        String customersEmail='';
        String customersMobile='';
        String customersAddress='';
        if(controller.customerInfo==null){
          // controller.getCustomerInfo();
        }else{
          customersName=controller.customerInfo!.customersName!;
          customersEmail=controller.customerInfo!.customersEmail!;
          customersMobile=controller.customerInfo!.customersMobile!;
          customersAddress= '${controller.customerInfo!.addressLines![0].addressLine1},${controller.customerInfo!.addressLines![0].addressLine2},${controller.customerInfo!.addressLines![0].addressLine3} - ${controller.customerInfo!.addressLines![0].pincode!}';
        }
        return SafeArea(
          child: Container(
            color: AppColors.white,
            child: Column(
              children: [
                 Header(title: 'account_setting'.tr, backBtn: false, cartBtn: false),
                Container(
                  color: AppColors.appColor,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(customersName,style: const TextStyle(fontFamily:'inter',color: AppColors.white,fontSize: 14,fontWeight: FontWeight.bold)),
                            InkWell(
                              onTap: () {
                              Locale? currentLocale = Get.locale;
                              if (currentLocale == null || currentLocale == Locale('en', 'US')) {
                                 controller.changeToTamil();
                               }else{
                                 controller.changeToEnglish();
                               }
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.language,color: AppColors.appLiteColor,size: 16,),
                                  const SizedBox(width: 3,),
                                  Text('language'.tr,style: const TextStyle(fontFamily:'inter',color: AppColors.white)),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 3,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(customersEmail,style: const TextStyle(fontFamily:'inter',color: AppColors.white,fontSize: 13)),
                                Text(customersMobile,style: const TextStyle(fontFamily:'inter',color: AppColors.white,fontSize: 13))
                              ],
                            ),
                            InkWell(
                              onTap: (){
                                Get.to(RegisterScreen(phoneNo: '',customerInfo:controller.customerInfo));
                              },
                              child:  Row(
                                children: [
                                const Icon(Icons.edit,color: AppColors.appLiteColor,size: 16,),
                                const SizedBox(width: 3,),
                                Text('edit'.tr,style: const TextStyle(fontFamily:'inter',color: AppColors.white)),
                              ],),
                            )
                          ],
                        ),
                        const SizedBox(height: 13,),
                        const DashedHorizontalDivider(color: AppColors.white,width: double.infinity,dashWidth: 5,dashSpace: 8,),
                        const SizedBox(height: 13,),
                        Row(
                          children: [
                          const Icon(Icons.location_on,color: AppColors.appLiteColor,size: 30,),
                          const SizedBox(width: 10,),
                          Expanded(child: Text(customersAddress,textAlign: TextAlign.center,style: TextStyle(fontFamily:'inter',color: AppColors.white,fontSize: 13),)),
                        ],)
                      ],
                    ),
                  ),
                ),
          
                Expanded(
                  child:SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal:1),
                            leading: const CircleAvatar(
                              backgroundColor: AppColors.appBgLiteColor,
                              child: Icon(Icons.my_location,color: AppColors.orangeColor,),// Image URL
                              // backgroundImage: AssetImage(AppImages.locationImg), // Image URL
                            ),
                            title: Text('my_address'.tr,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                            subtitle: Text('add_address_for_delivering'.tr,style: TextStyle(color: AppColors.grayColor,fontSize: 12)),
                            onTap: () {
                              Get.to(SavedAddress());
                              // Handle tap
                              print('Tapped on ListTile');
                            },
                          ),
                          const DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 1,dashSpace: 0,),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 1),
                            leading: const CircleAvatar(
                              backgroundColor: AppColors.appBgLiteColor,
                              child: Icon(Icons.call,color: AppColors.orangeColor,),
                              // backgroundImage: AssetImage(AppImages.locationImg), // Image URL
                            ),
                            title: Text('customer_care_number'.tr,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                            subtitle: const Text('${AppStrings.customerCareNumber1}, ${AppStrings.customerCareNumber2}',style: TextStyle(color: AppColors.grayColor,fontSize: 12)),
                            onTap: () {
                              // Handle tap
                              print('Tapped on ListTile');
                            },
                          ),
                          const DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 1,dashSpace: 0,),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 1),
                            leading: const CircleAvatar(
                              backgroundColor: AppColors.appBgLiteColor,
                              child: Icon(Icons.access_time_outlined,color: AppColors.orangeColor,),// Image URL
                            ),
                            title: Text('customer_care_timings'.tr,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                            subtitle: const Text(AppStrings.customerCareTime,style: TextStyle(color: AppColors.grayColor,fontSize: 12)),
                            onTap: () {
                              // Handle tap
                              print('Tapped on ListTile');
                            },
                          ),
                          const DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 1,dashSpace: 0,),
                          InkWell(
                            onTap: (){
                              Get.to(WebViewPage(page:'about_us'.tr));
                            },
                            child:  Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                children: [
                                  Text('about_us'.tr,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15)),
                                ],
                              ),
                            ),
                          ),
                          const DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 1,dashSpace: 0,),
                           InkWell(
                             onTap: (){
                               Get.to(WebViewPage(page:'terms_and_condition'.tr));
                             },
                             child:  Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                children: [
                                  Text('terms_and_condition'.tr,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15)),
                                ],
                              ),
                              ),
                           ),
                          const DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 1,dashSpace: 0,),
                          InkWell(
                            onTap: (){
                              Get.to(WebViewPage(page:'privacy_policy'.tr));
                            },
                            child:  Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                children: [
                                  Text('privacy_policy'.tr,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15)),
                                ],
                              ),
                            ),
                          ),
                          const DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 1,dashSpace: 0,),
                          InkWell(
                            onTap: (){},
                            child:  Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                children: [
                                  Text('rate_us_on_play_store'.tr,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15)),
                                ],
                              ),
                            ),
                          ),
                          const DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 1,dashSpace: 0,),
                          const SizedBox(height: 10,),
                            ],),
                        ),
                        Divider(color: Colors.grey[200],height: 10,thickness: 10,),
                        // SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          InkWell(
                            onTap: (){
                              controller.onLogOut();
                            },
                            child:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text('sign_out'.tr,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15)),
                                  const SizedBox(width: 5,),
                                  const Icon(Icons.logout_rounded,color: AppColors.appLiteColor,)
                                ],
                              ),
                            ),
                          ),
                          ],)
                      ],
                    ),
                  ),),
              ],
            ),
          ),
        );
      }
    );
  }
}
