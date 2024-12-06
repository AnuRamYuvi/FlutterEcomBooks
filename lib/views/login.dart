import 'dart:core';
import 'dart:io';
import 'dart:ui';
import 'package:ecom_books/constants/AppColors.dart';
import 'package:ecom_books/constants/size_config.dart';
import 'package:ecom_books/views/Widgets/loginSlider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import '../constants/AppStrings.dart';
import '../controllers/LoginScreenController.dart';
import 'dashboard/widget/horizontalDashLine.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final LoginScreenController loginScreenController = Get.put(LoginScreenController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return GetBuilder<LoginScreenController>(
      initState: (_){
        loginScreenController.getAppSignature();
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginSlider(),

                Expanded(
                   child: PageView(
                       physics: NeverScrollableScrollPhysics(), // Disable scrolling
                       controller: controller.pageController,
                       children:[
                         Padding(
                           padding: const EdgeInsets.all(20.0),
                           child: SingleChildScrollView(
                             child: GestureDetector(
                               // onTap: (() => FocusScope.of(context).unfocus()),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,

                                 children: [
                                    Text('login_signup'.tr,textAlign: TextAlign.start, style: TextStyle(fontFamily:'inter',fontSize: 20, fontWeight: FontWeight.bold)),
                                   const SizedBox(height: 10,),

                                   Row(
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                     children: [
                                        Padding(
                                         padding:  const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                         child: Text('text_91'.tr,style: const TextStyle(fontFamily:'inter',fontSize: 16,fontWeight: FontWeight.bold),),
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
                                           onTap: (){
                                             if(controller.openHint && Platform.isAndroid) {
                                               controller.onFocusChange();
                                             }
                                           },
                                           maxLength: 10,
                                           keyboardType: TextInputType.phone,
                                           decoration:  InputDecoration(
                                             contentPadding:
                                             const EdgeInsets.symmetric(
                                                 vertical: 4, horizontal: 1),
                                             border: InputBorder.none,
                                             counterText: "",
                                             hintText: 'mobile_number'.tr,
                                             // labelText: 'Enter your phone number ',
                                             // Style for the typed text
                                             hintStyle: const TextStyle(
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
                                               return 'Please enter a phone number';
                                             }else if(!phoneRegex.hasMatch(value)){
                                               return "Please enter a valid phone number";
                                             }
                                             return null;
                                           },
                                           controller: controller.phoneController,
                                         ),
                                       ),
                                     ],
                                   ),
                                   const DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 10,dashSpace: 0,),

                                   const SizedBox(height: 20,),
                                   SizedBox(
                                     width: double.infinity,
                                     height: 50,
                                     child: ElevatedButton(
                                         onPressed: (){
                                           // controller.changePage(1);
                                           FocusScope.of(context).unfocus();
                                           controller.onLogin();
                                           },
                                         style: ButtonStyle(
                                           backgroundColor: MaterialStateProperty.all<Color>(AppColors.appColor), // Set the background color
                                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                             RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(10.0), // Set the button's border radius
                                             ),
                                           ),
                                         ),
                                         child:  Text('send_verification'.tr,style: TextStyle(fontFamily:'inter',color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),)),
                                   ),

                                   Padding(
                                     padding: const EdgeInsets.all(18.0),
                                     child: RichText(
                                       textAlign: TextAlign.center,
                                       text:  TextSpan(
                                         style: TextStyle(fontFamily:'inter',
                                           color: Colors.black,
                                           fontSize: 15.0,
                                         ),
                                         children: [
                                           TextSpan(
                                             text: 'by_continuing_you'.tr,
                                           ),
                                           TextSpan(
                                             text: 'terms_and_condition'.tr,
                                             style: TextStyle(fontFamily:'inter',color: AppColors.appColor),
                                           ),
                                           TextSpan(
                                             text: AppStrings.amp,
                                           ),
                                           TextSpan(
                                             text: 'privacy_policy'.tr,
                                             style: TextStyle(fontFamily:'inter',color: AppColors.appColor),
                                           ),
                                         ],
                                       ),
                                     ),

                                   ),
                                   Center(
                                     child: RichText(
                                       textAlign: TextAlign.center,
                                       text:  TextSpan(
                                         style: TextStyle(fontFamily:'inter',
                                           color: Colors.black,
                                           fontSize: 14.0,
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
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(20.0),
                           child: SingleChildScrollView(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                  Text('verify_otp'.tr,textAlign: TextAlign.start, style: TextStyle(fontFamily:'inter',fontSize: 20, fontWeight: FontWeight.bold)),
                                 const SizedBox(height: 10,),
                                  Text('one_time_password_sent'.tr,textAlign: TextAlign.start,style: TextStyle(fontFamily:'inter',fontSize: 15,)),
                                 // const SizedBox(height: 10,),
                             
                                 OtpTextField(
                                   handleControllers: (controllers) {
                                     controller.otpControllers = controllers; // Assign the received controllers
                                   },
                                   numberOfFields: 4,
                                   borderColor: Colors.transparent,
                                   fillColor: AppColors.liteGray,
                                   focusedBorderColor: Colors.green,
                                   filled: true,
                                   // fieldHeight: 55,
                                   fieldWidth: 45,
                                   borderWidth: 2,
                                   margin: EdgeInsets.all(8),
                                   decoration: InputDecoration(
                                     border: OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.green, width: 1),
                                       borderRadius: BorderRadius.circular(10),
                                     ),
                                   ),
                                   //set to true to show as box or false to show as dash
                                   showFieldAsBox: true,
                                   cursorColor: AppColors.appColor,
                             
                                   textStyle: TextStyle(fontFamily:'inter',fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15,),
                                   borderRadius: BorderRadius.circular(10),
                             
                                   // decoration: BoxDecoration(
                                   //   border: Border(
                                   //     bottom: BorderSide(width: 1, color: Colors.green), // Set green color for bottom border
                                   //   ),
                                   // ),
                                   //runs when a code is typed in
                                   onCodeChanged: (String code) {
                                     print("onCodeChanged${code}");

                                     // controller.otpInput=code;
                                   },
                                   //runs when every textfield is filled
                                   onSubmit: (String verificationCode){
                                     // controller.onCodeChanged(verificationCode);
                                     if(verificationCode.length==4) {
                                       controller.otpInput=verificationCode;
                                       controller.update();
                                       controller.onVerifyOtp(verificationCode);
                                     }
                                   }, // end onSubmit
                                 ),
                                 const SizedBox(height: 10,),
                                 SizedBox(
                                   width: double.infinity,
                                   height: 50,
                                   child: ElevatedButton(
                                       onPressed: (){
                                         controller.onVerifyOtp(controller.otpInput);
                                       },
                                       style: ButtonStyle(
                                         backgroundColor: MaterialStateProperty.all<Color>(AppColors.appColor), // Set the background color
                                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                           RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(10.0), // Set the button's border radius
                                           ),
                                         ),
                                       ),
                                       child:  Text('verify_continue'.tr,style: TextStyle(fontFamily:'inter',color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),)),
                                 ),
                                 const SizedBox(height: 10,),
                             
                                 Text('entered_incorrect_number'.tr,textAlign: TextAlign.start,style: TextStyle(fontFamily:'inter',fontSize: 14,)),
                                 InkWell(
                                   onTap: (){
                                    controller.changePage(0);
                                    controller.onClose();
                                   },
                                  child: Text('change_number'.tr,textAlign: TextAlign.start,style: TextStyle(fontFamily:'inter',fontSize: 14,color: Colors.blue[700],decoration: TextDecoration.underline,))),
                             
                               ],
                             ),
                           ),
                         )
                       ]),
                 ),


              ],
            ),
          ),
        );
      }
    );
  }
}


