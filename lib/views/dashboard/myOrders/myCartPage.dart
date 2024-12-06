import 'package:ecom_books/constants/AppColors.dart';
import 'package:ecom_books/views/Widgets/header.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/AppImages.dart';
import '../../../constants/AppStrings.dart';
import '../../../constants/size_config.dart';
import '../../../controllers/dashboard/categories/product/productController.dart';
import '../../../controllers/dashboard/categories/product/productDetailController.dart';
import '../../../controllers/dashboard/home/homePageController.dart';
import '../../../controllers/dashboard/myOrders/myCartPageController.dart';
import '../../../models/dashboard/categories/cartModel.dart';
import '../categories/product/productListView.dart';
import '../home/Address/savedAddress.dart';
import '../mainScreen.dart';
import '../widget/horizontalDashLine.dart';

class MyCartPage extends StatelessWidget {
   MyCartPage({super.key});
  final MyCartPageController myCartPageController =Get.put(MyCartPageController());
   final ProductDetailController productDetailController =Get.put(ProductDetailController());

   @override
  Widget build(BuildContext context) {
    return GetBuilder<MyCartPageController>(
      initState: (_){
        myCartPageController.cartData=null;
        myCartPageController.onRefreshCartAddress();
      },
      builder: (controller) {
        return WillPopScope(
        onWillPop: () async {
          if (Get.isRegistered<ProductController>()) {
            Get.find<ProductController>().refreshPagingController();
          }
          return true;
        },
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child:controller.cartData !=null && controller.cartData!.cartLines !=null && controller.cartData!.cartLines!.isNotEmpty?
              Column(
                 children: [
                   Header(title: 'My Cart', backBtn: true, cartBtn: false,
                    onBack: (){
                     if (Get.isRegistered<ProductController>()) {
                     Get.find<ProductController>().refreshPagingController();}
                     Get.back();},
                   ),
                   controller.cartData!.cartTotalSavings!=null && controller.cartData!.cartTotalSavings!>0?
                   Container(
                     decoration: const BoxDecoration(
                       color: AppColors.appLiteColor1,
                       borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft:Radius.circular(10))
                     ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text('${AppStrings.rupeeSymbol}${controller.cartData!.cartTotalSavings!.toStringAsFixed(2)} saved on this order',style: TextStyle(color:AppColors.appColor,fontSize: 12,fontWeight: FontWeight.bold),),
                        Image.asset(height: 50,AppImages.yayImg)
                        ],
                      ),
                    ),
                   ):Container(),
                   Expanded(
                     child:SingleChildScrollView(
                       child: Column(
                         children: [
                         Padding(
                           padding: const EdgeInsets.only(left: 15.0,right: 15,top: 15),
                           child: Column(
                           children: [
                              Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                Text('review_items'.tr,style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                               InkWell(
                                 onTap: (){controller.removeAllDialog();},
                                   child:  Text('remove_all'.tr,style: TextStyle(color: AppColors.red,fontSize: 14,fontWeight: FontWeight.bold),)),
                               ],),
                              const SizedBox(height: 15,),
                              Container(
                                decoration: BoxDecoration(
                                 border: Border.all(color: AppColors.appBgLiteColor,width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('no_of_items'.tr,style: TextStyle(color: AppColors.grayColor,fontSize: 13,fontWeight: FontWeight.bold),),
                                          Text('${controller.cartData!.cartTotalItems}',style: TextStyle(color: AppColors.orangeColor,fontSize: 13,fontWeight: FontWeight.bold),),
                                        ],),
                                        ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: controller.cartData!.cartLines!.length,
                                        itemBuilder: (context, index) {
                                          CartLines cartLines=controller.cartData!.cartLines![index];
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 12.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap:(){
                                                        productDetailController.viewDetails(null,cartLines.productsCode!,false);
                                                      },
                                                      child: Card(
                                                        surfaceTintColor:Colors.white,
                                                        elevation:10,
                                                        child: CachedNetworkImage(
                                                          height: 55,
                                                          width: 55,
                                                          imageUrl: cartLines.productsImages!,
                                                          placeholder: (context, url) => Center(
                                                            child: Image.asset(
                                                              AppImages.placeholder,
                                                            ),
                                                          ),
                                                          errorWidget: (context, url, error) =>Center(
                                                            child: Image.asset(
                                                              AppImages.placeholder,
                                                            ),
                                                          ),
                                                          fadeInDuration: Duration.zero, // Remove fade-in animation
                                                          fadeOutDuration: Duration.zero,
                                                          placeholderFadeInDuration: Duration.zero,
                                                        ),
                                                      ),
                                                    ),
                                                   SizedBox(width: 10,),
                                                   Column(
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                       SizedBox(
                                                           width:SizeConfig.screenWidth!/1.5,
                                                           child: Text('${cartLines.productsName!}',style: TextStyle(color: AppColors.black,fontSize: 13,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                                                       Text(cartLines.unitsName!,style: TextStyle(color: AppColors.grayColor,fontSize: 12),),
                                                       SizedBox(
                                                         width:SizeConfig.screenWidth!/1.5,
                                                         child: Row(
                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                           children: [
                                                             Text('${AppStrings.rupeeSymbol}${cartLines.salesPrice}',style: TextStyle(color: AppColors.black,fontSize: 13,fontWeight: FontWeight.bold),),
                                                             Container(
                                                               height: 28,
                                                               width:90,
                                                               decoration: BoxDecoration(
                                                                 color: AppColors.appColor,
                                                                 borderRadius: BorderRadius.circular(10),
                                                               ),
                                                               child: Row(
                                                                 crossAxisAlignment: CrossAxisAlignment.center,
                                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                 children: [
                                                                   InkWell(
                                                                       onTap: (){
                                                                           if (cartLines.finalQty == 1) {
                                                                             controller.postCart(cartLines.productsCode!, cartLines.unitsId,0, 'zero');
                                                                           } else {
                                                                             controller.postCart(cartLines.productsCode!, cartLines.unitsId,(cartLines.finalQty! - 1), 'subtract');
                                                                           }
                                                                       },
                                                                       child: const Padding(
                                                                         padding: EdgeInsets.all(5.0),
                                                                         child: Icon(Icons.remove,color: AppColors.white,size: 16),
                                                                       )),
                                                                       Text('${cartLines.finalQty}',style: const TextStyle(color: AppColors.white,fontSize: 11,fontWeight: FontWeight.bold),),
                                                                       InkWell(
                                                                           onTap: (){
                                                                           controller.postCart(cartLines.productsCode!, cartLines.unitsId, 1, 'add',);
                                                                        },
                                                                       child: const Padding(
                                                                         padding: EdgeInsets.all(5.0),
                                                                         child: Icon(Icons.add,color: AppColors.white,size: 16,),
                                                                       )),
                                                                 ],),
                                                             ),
                                                           ],
                                                         ),
                                                       ),

                                                     ],)
                                                  ],
                                                ),

                                              ],
                                            ),
                                          );
                                        }),
                                        SizedBox(height: 12,),
                                         Row(
                                          children: [
                                          const Icon(Icons.add_circle_outline_rounded,color: AppColors.appLiteColor,size: 20,),
                                          const SizedBox(width: 10,),
                                          Text('add_more_items'.tr,style: TextStyle(color: AppColors.black,fontWeight: FontWeight.bold,fontSize: 14),)
                                        ],)

                                    ],),
                                ),
                              ),
                               SizedBox(height: 10,),
                             ]),
                          ),
                           const Divider(color: AppColors.appBgLiteColor,height: 8,thickness: 8,),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                 Row(
                                   children: [
                                   Text('${'pinCode'.tr} ${controller.customerInfo!.addressLines![0].pincode}',style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                                   SizedBox(width: 10,),
                                   InkWell(
                                     onTap: (){Get.to(SavedAddress());},
                                       child: Text('change'.tr,style: TextStyle(color: AppColors.orangeColor,fontSize: 14,fontWeight: FontWeight.bold),)),
                                 ],),
                                  SizedBox(height: 5,),
                                  Text('${'delivery_address'.tr} : ${controller.customerInfo!.addressLines![0].addressLine1},${controller.customerInfo!.addressLines![0].addressLine2},${controller.customerInfo!.addressLines![0].addressLine3} - ${controller.customerInfo!.addressLines![0].pincode!}'
                                    ,style: TextStyle(color: AppColors.black,fontSize: 13,fontWeight: FontWeight.bold),)
                              ],),
                            ),
                           const Divider(color: AppColors.appBgLiteColor,height: 8,thickness: 8,),

                           Padding(
                             padding: const EdgeInsets.all(15.0),
                             child: Column(
                               children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.appLiteColor1,
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  child:  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        const Icon(CupertinoIcons.bolt_fill,color: AppColors.appLiteColor,size: 30,),
                                        const SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                          Text('express_delivery'.tr,style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 7,),
                                          Text('your_order_will_be_delivered_within_45_minutes'.tr,style: TextStyle(color: AppColors.grayColor,fontSize: 11,fontWeight: FontWeight.bold))
                                        ],)
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('redeem'.tr,style: TextStyle(color: AppColors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                                    SizedBox(height: 10,),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border:Border.all(color: AppColors.appBgLiteColor,width: 1)

                                      ),
                                      child:  Padding(
                                        padding: EdgeInsets.only(left: 10.0,top: 10,bottom: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Image.asset(AppImages.loyaltyIcon, height: 40, width: 40),
                                                  const SizedBox(width: 10),
                                                   Flexible(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'loyalty_points'.tr,
                                                          style: TextStyle(
                                                            color: AppColors.black,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          'you_can_redeem_only_10_of_order_total'.tr,
                                                          style: TextStyle(
                                                            color: AppColors.grayColor,
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          maxLines: 2,
                                                        ),
                                                        controller.cartData!.isApplyLoyalty!=null && controller.cartData!.isApplyLoyalty==true?
                                                        Text(
                                                          'Use ${ controller.cartData!.loyalityRedemed!.toStringAsFixed(2)} from your available balance of ${controller.customerInfo!.loyalityBalance!.toStringAsFixed(2)}',
                                                          style: TextStyle(
                                                            color: AppColors.appColor,
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          maxLines: 2,
                                                        ):Container(),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                controller.cartData!.isApplyLoyalty!=null && controller.cartData!.isApplyLoyalty==false?
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: AppColors.appLiteColor1,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          controller.customerInfo!.loyalityBalance!.toStringAsFixed(2),
                                                          style: const TextStyle(
                                                            color: AppColors.appColor,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                         Text(
                                                          'available_balance'.tr,
                                                          style: TextStyle(
                                                            color: AppColors.appColor,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ):Container(),

                                                Checkbox(
                                                  value:controller.cartData!.isApplyLoyalty ?? false,
                                                  onChanged: (bool? newValue) {
                                                    controller.onLoyaltyApply(newValue);
                                                    controller.update();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],),
                                 SizedBox(height: 15,),
                                 Stack(
                                   children: [
                                     SizedBox(
                                       height: controller.cartData!.isApplyLoyalty !=null && controller.cartData!.isApplyLoyalty==true && controller.cartData!.loyalityRedemed !=0?255:230,
                                       child: Center(
                                         child: SvgPicture.asset(
                                           AppImages.paymentSummary,
                                           width: double.infinity,
                                           height: double.infinity,
                                           fit: BoxFit.fill,// Adjust height as needed
                                         ),
                                       ),
                                     ),
                                     Positioned(
                                       top: 2,
                                       right: 10,
                                       left: 10,
                                       child:Padding(
                                         padding: const EdgeInsets.all(10.0),
                                         child: Column(
                                           children: [
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text('total_amount'.tr,style: TextStyle(color: AppColors.black,fontSize: 14),),
                                                 Text('${AppStrings.rupeeSymbol} ${double.parse(controller.cartData!.cartTotal!).toStringAsFixed(2)}',style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                                               ],),
                                             SizedBox(height: 10),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text('discount_on_rs'.tr,style: TextStyle(color: AppColors.black,fontSize: 14),),
                                                 Text('${AppStrings.rupeeSymbol} ${controller.cartData!.cartTotalSavings!.toStringAsFixed(2)}',style: TextStyle(color: AppColors.appColor,fontSize: 14,fontWeight: FontWeight.bold)),
                                               ],),
                                             SizedBox(height: 10),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text('packing_charge'.tr,style: TextStyle(color: AppColors.black,fontSize: 14),),
                                                 Text('${AppStrings.rupeeSymbol} ${0.00.toStringAsFixed(2)}',style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                                               ],),
                                             SizedBox(height: 10),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text('delivery_charge'.tr,style: TextStyle(color: AppColors.black,fontSize: 14),),
                                                 Text('${AppStrings.rupeeSymbol} ${controller.cartData!.deliveryCharges!.toStringAsFixed(2)}',style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                                               ],),
                                             controller.cartData!.isApplyLoyalty !=null && controller.cartData!.isApplyLoyalty==true && controller.cartData!.loyalityRedemed !=0?
                                             Padding(
                                               padding: const EdgeInsets.only(top: 10.0),
                                               child: Row(
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [
                                                   Text('loyalty_points_redeemed'.tr,style: TextStyle(color: AppColors.black,fontSize: 12),),
                                                   Text('${AppStrings.rupeeSymbol} ${controller.cartData!.loyalityRedemed!.toStringAsFixed(2)}',style: TextStyle(color: AppColors.appColor,fontSize: 12,fontWeight: FontWeight.bold)),
                                                 ],),
                                             ):Container(),

                                             SizedBox(height: 10),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text('round_off'.tr,style: TextStyle(color: AppColors.black,fontSize: 12),),
                                                 Text('${AppStrings.rupeeSymbol} ${double.parse(controller.cartData!.roundOff!).toStringAsFixed(2)}',style: TextStyle(color: AppColors.black,fontSize: 12,fontWeight: FontWeight.bold)),
                                               ],),
                                             SizedBox(height: 10),
                                             const DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 5,dashSpace: 8,),
                                             SizedBox(height: 10),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text('amount_to_pay'.tr,style: TextStyle(color: AppColors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                                                 Text('${AppStrings.rupeeSymbol} ${controller.cartData!.cartGrandTotal!.toStringAsFixed(2)}',style: TextStyle(color: AppColors.appColor,fontSize: 15,fontWeight: FontWeight.bold)),
                                               ],),
                                             SizedBox(height: 5),
                                              Row(
                                               mainAxisAlignment: MainAxisAlignment.start,
                                               children: [
                                                 Text('all_prices_will_be_inclusive_of_tax'.tr,style: TextStyle(color: AppColors.black,fontSize: 12)),
                                               ],
                                             ),
                                           ],),
                                       ),
                                     ),
                                       ],
                                 ),


                             ],),
                           )

                         ],)
                       ,)),
                ],
              ):
              controller.cartData !=null && (controller.cartData!.cartLines == null || controller.cartData!.cartLines!.isEmpty)?
              Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppImages.emptyCart,
                          width: 130,
                          height: 130,
                          fit: BoxFit.fill,// Adjust height as needed
                        ),
                        const SizedBox(height: 10),
                         Text('your_cart_is_empty'.tr,style: TextStyle(color: AppColors.appLiteColor,fontSize: 15,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10),
                         Text('looks_like_you_havent_added_anything_to_your_cart'.tr,style: TextStyle(color: AppColors.grayColor,fontSize: 11,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: SizeConfig.screenWidth!/1.3,
                          child: ElevatedButton(
                              onPressed: () {
                                if (Get.isRegistered<ProductController>()) {
                                  Get.find<ProductController>().refreshPagingController();
                                }
                                Get.back();
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
                                'continue_shopping'.tr,
                                style: TextStyle(
                                    fontFamily: 'inter',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              )),
                        )
                      ],
                    ),
                  )
              ):Center(child:Image.asset(height:100,AppImages.appLogoImg)),
            ),
            bottomNavigationBar: controller.cartData !=null && controller.cartData!.cartLines !=null && controller.cartData!.cartLines!.isNotEmpty?
             SafeArea(
               child: Container(
                height: 70,
                child: Opacity(
                  opacity: controller.shopCloseTime?0.5:1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: SizeConfig.screenWidth!/2.2,
                        child: InkWell(
                          onTap: (){
                            controller.openBottomSheet();
                          },
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Card(
                                elevation: 5,
                                surfaceTintColor: AppColors.white,
                                color: AppColors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: SvgPicture.asset(
                                    controller.selectedOption=='online'? AppImages.online:AppImages.cod,
                                    width: 40, // Adjust width as needed
                                    height: 40,// Adjust height as needed
                                  ),
                                ),
                              ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Text(controller.selectedOption=='online'?'online'.tr:'cod'.tr,style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                              Text('change_payment_mode'.tr,style: TextStyle(color: AppColors.red,fontSize: 8),),
                            ],),
                              Icon(Icons.keyboard_arrow_up_rounded,color: AppColors.black,size: 20,),
                          ],),
                        ),),
                      SizedBox(width: SizeConfig.screenWidth!/2.2,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            controller.confirmOrderDialog(controller.cartData!.cartGrandTotal!,controller.customerInfo!.customersMobile!,controller.customerInfo!.customersEmail!,controller.customerInfo!.addressLines![0].id!);
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
                            'pay_now'.tr,
                            style: TextStyle(
                                fontFamily: 'inter',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )),
                    )
                      ],),
                  ),
                ),
                           ),
             ):Container(height: 0,),
          ),
        );
      }
    );
  }
}
