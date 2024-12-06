import 'package:ecom_books/constants/AppColors.dart';
import 'package:ecom_books/constants/AppImages.dart';
import 'package:ecom_books/controllers/dashboard/home/Address/savedAddressController.dart';
import 'package:ecom_books/views/Widgets/header.dart';
import 'package:ecom_books/views/dashboard/home/Address/mapPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../constants/size_config.dart';

class SavedAddress extends StatelessWidget {
   SavedAddress({super.key});
final SavedAddressController savedAddressController =Get.put(SavedAddressController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedAddressController>(
     initState: (_){savedAddressController.getAddress();},
      builder: (controller) {
        return Scaffold(
          // backgroundColor: AppColors.appBgLiteColor,
            body: SafeArea(
                child: Container(
                  color: AppColors.appBgLiteColor,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(title: 'My Address', backBtn: true, cartBtn: false),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text('saved_address'.tr,style: TextStyle(color: AppColors.grayColor,fontSize: 14,fontWeight: FontWeight.bold),),
                      ),
                      controller.customerInfo!=null?
                      Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                                   decoration: BoxDecoration(
                                     color: AppColors.white,
                                     borderRadius: BorderRadius.circular(10)
                                   ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: controller.customerInfo!.addressLines!.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          index!=0? const Padding(
                                            padding: EdgeInsets.only(top: 10.0,bottom: 10),
                                            child: Divider(
                                                color: AppColors.liteGray,
                                                  // Height of the vertical divider
                                                  thickness: 1, // Thickness of the vertical divider
                                                  // End indent of the vertical divider (space on the right)
                                                ),
                                          )
                                          :Container(),

                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const CircleAvatar(
                                                  backgroundColor: AppColors.appBgLiteColor, // Background color
                                                  radius: 15.0,
                                                  child: Icon(Icons.location_on,color: AppColors.appColor,size: 20,)),

                                              SizedBox(width: 10,),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: SizeConfig.screenWidth!/1.4,
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text( controller.customerInfo!.addressLines![index].addressType!,style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                                                        controller.customerInfo!.addressLines![index].isDefault=="true"?Container(
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
                                                  SizedBox(height: 5,),
                                                  SizedBox(
                                                      width: SizeConfig.screenWidth!/1.4,
                                                      child: Column(
                                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('${controller.customerInfo!.addressLines![index].addressLine1!}, ${controller.customerInfo!.addressLines![index].addressLine2!}, ${controller.customerInfo!.addressLines![index].addressLine3!} - ${controller.customerInfo!.addressLines![index].pincode!}',style: TextStyle(color: AppColors.grayColor,fontSize: 13),),

                                                          controller.customerInfo!.addressLines![index].alternativeMobile!=null &&controller.customerInfo!.addressLines![index].alternativeMobile!.trim()!=''?
                                                          Padding(
                                                            padding: const EdgeInsets.only(top: 5.0),
                                                            child: Text('${'alternative_number'.tr}${controller.customerInfo!.addressLines![index].alternativeMobile!}',style: TextStyle(color: AppColors.grayColor,fontSize: 13),),
                                                          ):Container(),
                                                        ],
                                                      )),
                                                  controller.customerInfo!.addressLines![index].isDefault!="true"?
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 5.0),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: AppColors.liteGray,width: 1),
                                                            borderRadius: BorderRadius.circular(5)
                                                          ),
                                                          child: InkWell(
                                                            onTap:(){controller.deleteAddressDialog(controller.customerInfo!.addressLines![index].id!);},
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8),
                                                              child: Row(
                                                                children: [
                                                                  Icon(Icons.delete_outline_outlined,color: AppColors.red,size: 10,),
                                                                  SizedBox(width: 5,),
                                                                  Text('delete'.tr,style: TextStyle(color: AppColors.red,fontSize: 10),)
                                                                ],),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10,),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color:AppColors.appColor,
                                                              borderRadius: BorderRadius.circular(5)
                                                          ),
                                                          child: InkWell(
                                                            onTap:(){controller.setDefaultAddressDialog(controller.customerInfo!.addressLines![index].id!,controller.customerInfo!.addressLines![index]); },
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8),
                                                              child:Text('set_as_default'.tr,style: const TextStyle(color: AppColors.white,fontSize: 10),)

                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ):Container(),
                                                ],),
                                            ],
                                          )
                                        ],);
                                    }
                                    ),
                                  ),
                                ),

                          ),
                        ),
                      ):
                      Expanded(child: Center(child: Image.asset(height:100,AppImages.appLogoImg),)),
                    ],
                  ),
                )
            ),
            bottomNavigationBar:  controller.customerInfo!=null?Container(
                             height: 55,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                 Get.to(MapScreen());
                                  },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty
                                      .all<Color>(AppColors
                                      .appColor), // Set the background color
                                  shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                  10.0), // Set the button's border radius
                                  ),
                                  ),
                                  ),
                                  child:  Text(
                                  'add_new_address'.tr,
                                  style: TextStyle(
                                  fontFamily: 'inter',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                                  )),
                            ),
            ):Container(height: 0,),
        );
      }
    );
  }
}
