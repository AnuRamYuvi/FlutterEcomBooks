import 'package:ecom_books/constants/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../constants/AppStrings.dart';
import '../controllers/RegisterScreenController.dart';
import '../models/dashboard/home/homeModel.dart';
import 'dashboard/widget/horizontalDashLine.dart';

class RegisterScreen extends StatelessWidget {
   final String phoneNo;
   final CustomerInfo? customerInfo;
   RegisterScreen({super.key, required this.phoneNo, required this.customerInfo});
  final RegisterScreenController registerScreenController = Get.put(RegisterScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterScreenController>(
      initState: (_){
        registerScreenController.setData(phoneNo,customerInfo);
      },
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              color: AppColors.white,
                child:Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(onTap:(){Get.back();},child: const Icon(Icons.arrow_circle_left_outlined,size: 30,)),
                    const SizedBox(height: 8,),
                    controller.isRegister ? Text('create_account'.tr,style: TextStyle(fontFamily:'inter',fontSize: 20,fontWeight: FontWeight.bold),):
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('your_personal_info'.tr,style: TextStyle(fontFamily:'inter',fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.black),),
                        SizedBox(height: 2,),
                        Text('edit_your_personal_info'.tr,style: TextStyle(fontFamily:'inter',fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.grayColor),)
                    ],),
                    const SizedBox(height: 15,),
                     Text('user_name'.tr,style: TextStyle(fontFamily:'inter',fontSize: 14,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.person_rounded,
                            size: 25,
                            color: AppColors.grayColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Container(
                            width: 1, // Width of the vertical divider
                            height: 40, // Height of the vertical divider
                            color: AppColors.liteGray,
                            // Margin around the vertical divider
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            decoration:  InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                              hintText: 'user_name'.tr,
                              // labelText: 'Enter your phone number ',
                              // Style for the typed text
                              hintStyle: TextStyle(
                                  fontFamily: 'inter',
                                  color: AppColors.grayColor,
                                  fontSize: 16),
                            ),
                            style: const TextStyle(
                                fontFamily: 'inter',
                                color: Colors.black,
                                fontSize: 16),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter userName';
                              }
                              return null;
                            },
                            controller: controller.userNameController,
                          ),
                        ),
                      ],
                    ),
                    const DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 10,dashSpace: 0,),
                    const SizedBox(height: 10,),
                     Text('email'.tr,style: TextStyle(fontFamily:'inter',fontSize: 14,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.email_rounded,
                            size: 25,
                            color: AppColors.grayColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Container(
                            width: 1, // Width of the vertical divider
                            height: 40, // Height of the vertical divider
                            color: AppColors.liteGray,
                            // Margin around the vertical divider
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            decoration:  InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                              hintText: 'example_gmail_com'.tr,
                              // labelText: 'Enter your phone number ',
                              // Style for the typed text
                              hintStyle: TextStyle(
                                  fontFamily: 'inter',
                                  color: AppColors.grayColor,
                                  fontSize: 16),
                            ),
                            style: const TextStyle(
                                fontFamily: 'inter',
                                color: Colors.black,
                                fontSize: 16),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a email';
                              }else if(!emailRegex.hasMatch(value)){
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            controller: controller.emailController,
                          ),
                        ),
                      ],
                    ),
                    const DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 10,dashSpace: 0,),
                    const SizedBox(height: 10 ,),
                     Text('gender'.tr,style: TextStyle(fontFamily:'inter',fontSize: 14,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      Column(
                        children: [
                          InkWell(
                            borderRadius:  const BorderRadius.all(Radius.circular(18)),
                            onTap: (){
                              controller.gender='MALE';
                              controller.update();
                            },
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: controller.gender=='MALE'?AppColors.appLiteColor:Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(18)),
                                border:  Border.all(color: AppColors.liteGray,width: 1)
                              ),
                              child: Icon(Icons.male,color: controller.gender=='MALE'?Colors.white:Colors.grey,size: 40,),
                            ),
                          ),
                          const SizedBox(height: 5,),
                           Text('male'.tr,style: TextStyle(fontFamily:'inter',fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.grayColor),)
                        ],
                      ),
                       // SizedBox(width: 20,),
                        Column(
                          children: [
                            InkWell(
                              borderRadius:  const BorderRadius.all(Radius.circular(18)),
                              onTap: (){
                                controller.gender='FEMALE';
                                controller.update();
                              },
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: controller.gender=='FEMALE'?AppColors.appLiteColor:Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                                    border:  Border.all(color: AppColors.liteGray,width: 1)
                                ),
                                child: Icon(Icons.female,color: controller.gender=='FEMALE'?Colors.white:Colors.grey,size: 40,),
                              ),
                            ),
                            const SizedBox(height: 5,),
                             Text('female'.tr,style: TextStyle(fontFamily:'inter',fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.grayColor),)
                          ],
                        ),
                    ],),
                
                    customerInfo!=null?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                         Text('date_of_birth'.tr,style: TextStyle(fontFamily:'inter',fontSize: 14,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 5,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.edit_calendar,
                                size: 25,
                                color: AppColors.grayColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                width: 1, // Width of the vertical divider
                                height: 40, // Height of the vertical divider
                                color: AppColors.liteGray,
                                // Margin around the vertical divider
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  controller.selectDate(context);
                                },
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  decoration:  InputDecoration(
                                    enabled: false,
                                    border: InputBorder.none,
                                    counterText: "",
                                    hintText: 'select_date_of_birth'.tr,
                                    // labelText: 'Enter your phone number ',
                                    // Style for the typed text
                                    hintStyle: TextStyle(
                                        fontFamily: 'inter',
                                        color: AppColors.grayColor,
                                        fontSize: 16),
                                  ),
                                  style: const TextStyle(
                                      fontFamily: 'inter',
                                      color: Colors.black,
                                      fontSize: 16),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please select date of birth';
                                    }
                                    return null;
                                  },
                                  controller: controller.dobController,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 10,dashSpace: 0,),
                      ],
                    ):Container()
                  ],
                ),
              ),
            )),
          ),
          bottomNavigationBar: SafeArea(
            child: SizedBox(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0,right: 15),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text('send_order_status_offers_on_whatsapp'.tr,style: TextStyle(fontSize: 12,color: AppColors.grayColor),),
                        Transform.scale(
                          scale: 0.6,
                          child: Switch(
                            value: controller.isSwitched,
                            onChanged: (value) {
                              controller.isSwitched = value;
                              controller.update();
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: (){
                            controller.onRegister();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.appColor), // Set the background color
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), // Set the button's border radius
                              ),
                            ),
                          ),
                          child:  Text(controller.isRegister ?'register_account'.tr:'update'.tr,style: TextStyle(fontFamily:'inter',color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)),
                    ),
                    const SizedBox(height: 10,),
                    RichText(
                      textAlign: TextAlign.center,
                      text:  TextSpan(
                        style: TextStyle(fontFamily:'inter',
                          color: Colors.black,
                          fontSize: 13.0,
                        ),
                        children: [
                          TextSpan(
                            text: 'having_trouble'.tr,
                          ),
                          TextSpan(
                            text: 'get_help'.tr,
                            style: TextStyle(fontFamily:'inter',color: AppColors.appColor,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
