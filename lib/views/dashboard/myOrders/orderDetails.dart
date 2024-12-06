import 'package:ecom_books/constants/AppColors.dart';
import 'package:ecom_books/constants/AppStrings.dart';
import 'package:ecom_books/controllers/dashboard/myOrders/orderDetailsController.dart';
import 'package:ecom_books/views/Widgets/header.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../constants/AppImages.dart';
import '../../../constants/size_config.dart';
import '../../../controllers/dashboard/categories/product/productController.dart';
import '../../../controllers/dashboard/categories/product/productDetailController.dart';
import '../../../models/dashboard/categories/cartModel.dart';
import '../../../models/dashboard/myOrders/orderDetails.dart';
import '../widget/horizontalDashLine.dart';

class OrderDetails extends StatelessWidget {
  final int? orderId;
  final int? dacNo;
   OrderDetails({super.key , required this.orderId, required this.dacNo});
  final OrderDetailsController orderDetailsController =Get.put(OrderDetailsController());
  final ProductDetailController productDetailController =Get.put(ProductDetailController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailsController>(
      initState: (_){
        orderDetailsController.orderDetails=null;
        orderDetailsController.loadOrderData(orderId);
        },
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
              child: Container(
                color: AppColors.white,
                child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(title: '#$orderId', backBtn: true, cartBtn: false),
                  controller.orderDetails!=null?
                  Expanded(
                      child: SingleChildScrollView(
                       child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('track_my_order'.tr,style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold),),

                              dacNo!=null &&dacNo!=0?
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                 children: [
                                    Text('delivery_authentication_code'.tr,style: TextStyle(color: AppColors.grayColor,fontSize: 14,fontWeight: FontWeight.bold),),
                                   Container(
                                     decoration: BoxDecoration(
                                       color: AppColors.appColor,
                                       borderRadius: BorderRadius.circular(5)
                                     ),
                                     child:Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text('$dacNo',style: TextStyle(color: Colors.white,fontSize: 10),),
                                     )
                                   )
                                 ],
                               ),
                              ):Container(),

                             SizedBox(height: 10,),
                              Opacity(
                               opacity:controller.orderConfirmedDate!=''?1.0:0.3,
                               child: Row(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                   // crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Image.asset(AppImages.orderConfirm ,height: 40,width: 40,),
                                   SizedBox(width: 10,),
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                      Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                       Text('order_confirmed'.tr,style: TextStyle(color: AppColors.orangeColor,fontSize: 14,fontWeight: FontWeight.bold),),
                                       SizedBox(width: 5,),
                                       Icon(Icons.task_alt,color: AppColors.orangeColor,size: 20,),
                                     ],),
                                       Text(controller.orderConfirmedDate!=''?controller.orderConfirmedDate:'Not yet',style: TextStyle(color: AppColors.grayColor,fontSize: 13),),
                                     ],)
                               ],),
                             )
                              ,SizedBox(height: 10,),
                              Opacity(
                                opacity:controller.orderProcessingDate!=''?1.0:0.3,
                               child: Row(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                   // crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Image.asset(AppImages.orderProcessing ,height: 40,width: 40,),
                                   const SizedBox(width: 10,),
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                      Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                       Text('processing'.tr,style: TextStyle(color: AppColors.processingStatusColor,fontSize: 14,fontWeight: FontWeight.bold),),
                                       SizedBox(width: 5,),
                                       Icon(Icons.task_alt,color: AppColors.processingStatusColor,size: 20,),
                                     ],),
                                       Text(controller.orderProcessingDate!=''?controller.orderProcessingDate:'Not yet',style: TextStyle(color: AppColors.grayColor,fontSize: 13),),
                                     ],)
                               ],),
                             ),
                             SizedBox(height: 10,),
                              Opacity(
                                opacity:controller.orderInvoiceDate!=''?1.0:0.3,
                               child: Row(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                   // crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Image.asset(AppImages.orderInvoice ,height: 40,width: 40,),
                                   SizedBox(width: 10,),
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                      Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                       Text('invoice'.tr,style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                                         SizedBox(width: 5,),
                                         Icon(Icons.task_alt,color: AppColors.black,size: 20,),
                                     ],),
                                       Text('${controller.orderInvoiceDate!=''?controller.orderInvoiceDate:'Not yet'}',style: TextStyle(color: AppColors.grayColor,fontSize: 13),),
                                     ],)
                               ],),
                             ),
                             SizedBox(height: 10,),
                              Opacity(
                                opacity:controller.orderShippedDate!=''?1.0:0.3,
                               child: Row(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                   // crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Image.asset(AppImages.orderShipped ,height: 40,width: 40,),
                                   SizedBox(width: 10,),
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                      Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                       Text('shipped'.tr,style: TextStyle(color: AppColors.shippingStatusColor,fontSize: 14,fontWeight: FontWeight.bold),),
                                         const SizedBox(width: 5,),
                                         const Icon(Icons.task_alt,color: AppColors.shippingStatusColor,size: 20,),
                                     ],),
                                       Text('${controller.orderShippedDate!=''?controller.orderShippedDate:'Not yet'}',style: TextStyle(color: AppColors.grayColor,fontSize: 13),),
                                     ],)
                               ],),
                             ),
                             SizedBox(height: 10,),
                              Opacity(
                                opacity:controller.orderDeliveredDate!=''?1.0:0.3,
                               child: Row(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                   // crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Image.asset(AppImages.orderDelivered ,height: 40,width: 40,),
                                   SizedBox(width: 10,),
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                       Text('delivered'.tr,style: TextStyle(color: AppColors.greenColor,fontSize: 14,fontWeight: FontWeight.bold),),
                                         SizedBox(width: 5,),
                                         Icon(Icons.task_alt,color: AppColors.greenColor,size: 20,),
                                     ],),
                                       Text('${controller.orderDeliveredDate!=''?controller.orderDeliveredDate:'Not yet'}',style: TextStyle(color: AppColors.grayColor,fontSize: 13),),
                                     ],)
                               ],),
                             ),
                              // SizedBox(height: 10,),
                            ],),

                        ),
                        const Divider(color: AppColors.appBgLiteColor,height: 8,thickness: 8,),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('selected_items'.tr,style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Text('no_of_items'.tr,style: TextStyle(color: AppColors.grayColor,fontSize: 13,fontWeight: FontWeight.bold),),
                                  Text('${controller.orderDetails!.ordersNoOfItems}',style: TextStyle(color: AppColors.orangeColor,fontSize: 13,fontWeight: FontWeight.bold),),
                                ],),
                              SizedBox(height: 10,),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.appBgLiteColor,width: 1),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 5,),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: controller.orderDetails!.orderLines!.length,
                                        itemBuilder: (context, index) {
                                          OrderLines orderLines=controller.orderDetails!.orderLines![index];
                                          return Padding(
                                            padding: const EdgeInsets.only(left: 10.0,right: 10,top: 5,bottom: 5),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    productDetailController.viewDetails(null,orderLines.productsCode!,true);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Card(
                                                        surfaceTintColor:Colors.white,
                                                        elevation:5,
                                                        child: CachedNetworkImage(
                                                          height: 55,
                                                          width: 55,
                                                          imageUrl: orderLines.productsImages!,
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
                                                      SizedBox(width: 10,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          SizedBox(
                                                              width:SizeConfig.screenWidth!/1.5,
                                                              child: Text('${orderLines.productsName}',style: TextStyle(color: AppColors.black,fontSize: 13,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                                                          SizedBox(
                                                            width:SizeConfig.screenWidth!/1.5,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text('${AppStrings.rupeeSymbol}${orderLines.ordersRate!.toStringAsFixed(2)}',style: TextStyle(color: AppColors.black,fontSize: 13,fontWeight: FontWeight.bold),),
                                                                Text('${'qty'.tr} ${orderLines.finalQty}',style: TextStyle(color: AppColors.grayColor,fontSize: 13,fontWeight: FontWeight.bold),),

                                                              ],
                                                            ),
                                                          ),

                                                        ],)
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),
                                          );
                                        }),
                                    SizedBox(height: 5,),
                                  ],),
                              ),
                            ],
                          ),
                        ),
                        const Divider(color: AppColors.appBgLiteColor,height: 8,thickness: 8,),
                        Padding(
                         padding: EdgeInsets.all(15.0),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text('delivery_address'.tr,style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                             SizedBox(height: 10,),
                             Container(
                               decoration: BoxDecoration(
                                 border: Border.all(color: AppColors.appColor,width: 1),
                                 borderRadius: BorderRadius.circular(10),
                               ),
                               child: Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                    // Text('${controller.orderDetails!.addressLine1!}',style: TextStyle(color: AppColors.black,fontSize: 13,fontWeight: FontWeight.bold)),
                                    //  SizedBox(height: 10,),
                                    //  Text('${controller.orderDetails!.addressLine2!}',style: TextStyle(color: AppColors.black,fontSize: 13,fontWeight: FontWeight.bold)),
                                    //  controller.orderDetails!.addressLine3!=null&& controller.orderDetails!.addressLine3!=''?
                                    //  Padding(
                                    //    padding: const EdgeInsets.only(top: 10.0),
                                    //    child: Text('${controller.orderDetails!.addressLine3!}',style: TextStyle(color: AppColors.black,fontSize: 13,fontWeight: FontWeight.bold)),
                                    //  ):Container(),
                                    //  SizedBox(height: 10,),
                                    //  Row(
                                    //    children: [
                                    //      Icon(Icons.location_on,color: AppColors.appLiteColor,),
                                    //      Text(addressType,style: TextStyle(color: AppColors.grayColor,fontSize: 13,fontWeight: FontWeight.bold)),
                                    //      Text(' ${controller.orderDetails!.addressType!}',style: TextStyle(color: AppColors.black,fontSize: 13,fontWeight: FontWeight.bold)),
                                    //    ],
                                    //  ),
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
                                             Text(controller.orderDetails!.addressType!,style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                                             SizedBox(height: 5,),
                                             SizedBox(
                                                 width: SizeConfig.screenWidth!/1.4,
                                                 child: Column(
                                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                     Text('${controller.orderDetails!.addressLine1!}, ${controller.orderDetails!.addressLine2!}, ${controller.orderDetails!.addressLine3!}',style: TextStyle(color: AppColors.grayColor,fontSize: 13),),

                                                      controller.orderDetails!.alternativeMobile!=null && controller.orderDetails!.alternativeMobile!.trim()!=''?
                                                      Padding(
                                                      padding: const EdgeInsets.only(top: 5.0),
                                                      child: Text('${'alternative_number'.tr}${controller.orderDetails!.alternativeMobile!}',style: TextStyle(color: AppColors.grayColor,fontSize: 13),),
                                                      ):Container(),
                                                   ],
                                                 )),
                                           ],),
                                       ],
                                     )
                                 ],),
                               ),
                             )
                           ]
                         )
                       ),
                        const Divider(color: AppColors.appBgLiteColor,height: 8,thickness: 8,),
                        Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('payment_summary'.tr,style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 10,),

                                  Stack(
                                    children: [
                                    Container(
                                    height: 225,
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
                                      top: 0,
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
                                                Text('${AppStrings.rupeeSymbol} ${controller.orderDetails!.ordersTotal??0.toStringAsFixed(2)}',style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                                              ],),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('discount_on_rs'.tr,style: TextStyle(color: AppColors.black,fontSize: 14),),
                                                Text('${AppStrings.rupeeSymbol} ${controller.orderDetails!.ordersDiscountAmount??0.00.toStringAsFixed(2)}',style: TextStyle(color: AppColors.appColor,fontSize: 14,fontWeight: FontWeight.bold)),
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
                                                Text('${AppStrings.rupeeSymbol} ${controller.orderDetails!.ordersDeliveryCharge??0.00.toStringAsFixed(2)}',style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                                              ],),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('loyalty_points_redeemed'.tr,style: TextStyle(color: AppColors.grayColor,fontSize: 12),),
                                                Text('${AppStrings.rupeeSymbol} ${controller.orderDetails!.loyalityRedeemed??0.toStringAsFixed(2)}',style: TextStyle(color: AppColors.greenColor,fontSize: 12,fontWeight: FontWeight.bold)),
                                              ],),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('round_off'.tr,style: TextStyle(color: AppColors.grayColor,fontSize: 12),),
                                                Text('${AppStrings.rupeeSymbol} ${controller.orderDetails!.roundOff??0.toStringAsFixed(2)}',style: TextStyle(color: AppColors.greenColor,fontSize: 12,fontWeight: FontWeight.bold)),
                                              ],),
                                            SizedBox(height: 10),
                                            const DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 5,dashSpace: 8,),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('amount_to_pay'.tr,style: TextStyle(color: AppColors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                                                Text('${AppStrings.rupeeSymbol} ${controller.orderDetails!.roundOff!>0?((controller.orderDetails!.ordersTotal!-controller.orderDetails!.ordersDiscountAmount!)-controller.orderDetails!.loyalityRedeemed!+controller.orderDetails!.ordersDeliveryCharge!+controller.orderDetails!.roundOff!).toStringAsFixed(2):
                                                ((controller.orderDetails!.ordersTotal!-controller.orderDetails!.ordersDiscountAmount!)-controller.orderDetails!.loyalityRedeemed!+controller.orderDetails!.ordersDeliveryCharge!-controller.orderDetails!.roundOff!).toStringAsFixed(2)}',style: TextStyle(color: AppColors.appColor,fontSize: 15,fontWeight: FontWeight.bold)),
                                              ],),
                                          ],),
                                      ),
                                  ),
                                        ]
                                  ),

                                  SizedBox(height: 10),
                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('all_prices_will_be_inclusive_of_tax'.tr,style: TextStyle(color: AppColors.grayColor,fontSize: 13)),
                                    ],
                                  ),
                                ]
                            )
                        ),
                        const Divider(color: AppColors.appBgLiteColor,height: 8,thickness: 8,),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(children: [
                            Text('mode_of_payment'.tr,style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                            Text(' ${controller.orderDetails!.ordersMode=='1'?'online'.tr:'cod'.tr}',style: TextStyle(color: AppColors.grayColor,fontSize: 14,fontWeight: FontWeight.bold))
                          ],),
                        )
                      ],),
                  )):
                  Expanded(child: Center(child:Image.asset(height:100,AppImages.appLogoImg))),
                ],
              ),),
          ),
        );
      }
    );
  }
}
