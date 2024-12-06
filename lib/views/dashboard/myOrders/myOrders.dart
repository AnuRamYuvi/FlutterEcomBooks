import 'package:ecom_books/constants/AppColors.dart';
import 'package:ecom_books/constants/AppImages.dart';
import 'package:ecom_books/controllers/dashboard/myOrders/myOrderController.dart';
import 'package:ecom_books/models/dashboard/myOrders/myOrdersModel.dart';
import 'package:ecom_books/views/Widgets/header.dart';
import 'package:ecom_books/views/dashboard/widget/horizontalDashLine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../constants/AppStrings.dart';
import 'orderDetails.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.white,
        child: Column(
          children: [
             Header(title: 'title_my_orders'.tr, backBtn: false, cartBtn: false),
            Expanded(
              child: GetBuilder<MyOrderController>(
                // initState: (_){myOrderController.initializedData();},
                builder: (controller) {
                  return RefreshIndicator(
                    onRefresh: ()=>Future.sync(controller.pagingController.refresh),
                    child:Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: PagedListView<int, Data>(
                      pagingController: controller.pagingController,
                      builderDelegate: PagedChildBuilderDelegate<Data>(
                      itemBuilder: (context, item, index) =>Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Container(
                              decoration: BoxDecoration(
                               color: AppColors.white,
                               borderRadius: BorderRadius.circular(12),
                               border: Border.all(color: AppColors.liteGray,width: 1)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10,),
                                   Padding(
                                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Row(
                                          children: [
                                             Text(
                                              'order_id'.tr,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'inter_medium',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '#${item.id}',
                                              style: const TextStyle(
                                                  color:AppColors.appColor,
                                                  fontFamily: 'inter_medium',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                         ),
                                         item.dacno!=null&&item.dacno!=0?
                                         Row(
                                           children: [
                                              Text(
                                               'dac'.tr,
                                               style: TextStyle(
                                                   color: Colors.black,
                                                   fontFamily: 'inter_medium',
                                                   fontSize: 15,
                                                   fontWeight: FontWeight.bold),
                                             ),
                                             Text(
                                               '${item.dacno}',
                                               style: const TextStyle(
                                                   color: AppColors.orangeColor,
                                                   fontFamily: 'inter_medium',
                                                   fontSize: 15,
                                                   fontWeight: FontWeight.bold),
                                             ),
                                           ],
                                         ):Container(),
                                       ],
                                     ),
                                   ),
                                   const SizedBox(height: 10,),
                                   const Padding(
                                     padding: EdgeInsets.symmetric(horizontal: 10.0),
                                     child: DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 5,dashSpace: 8,),
                                   ),
                                   const SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                             Text(
                                              'order_placed'.tr,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'inter',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              controller.formatDateTime(item.createdAt!),
                                              style: const TextStyle(
                                                  color: AppColors.grayColor,
                                                  fontFamily: 'inter',
                                                  fontSize: 12,
                                                 ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                             Text(
                                             'order_status'.tr,
                                              style: TextStyle(
                                                  color:Colors.black,
                                                  fontFamily: 'inter',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              item.ordersStatusText!,
                                              style: TextStyle(
                                                color: item.ordersStatus==1?AppColors.processingStatusColor:item.ordersStatus==2?AppColors.invoiceStatusColor:item.ordersStatus==3?AppColors.shippingStatusColor:
                                                item.ordersStatus==4?AppColors.greenColor:item.ordersStatus==5?AppColors.red:AppColors.grayColor,
                                                fontFamily: 'inter',
                                                fontSize: 12,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],),
                                  ),
                                  const SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                             Text(
                                              'no_of_items'.tr,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'inter',
                                                  fontSize: 14,
                                                  ),
                                            ),
                                            Text(
                                              '${item.ordersNoOfItems}',
                                              style: const TextStyle(
                                                color: AppColors.orangeColor,
                                                fontFamily: 'inter',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Text(
                                              'total_amount'.tr,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'inter',
                                                  fontSize: 14,
                                                  ),
                                            ),
                                            Text(
                                              '${AppStrings.rupeeSymbol}${item.roundOff!>0?((item.ordersTotal!-item.ordersDiscountAmount!)-item.loyalityRedeemed!+item.ordersDeliveryCharge!+item.roundOff!).toStringAsFixed(2):
                                               ((item.ordersTotal!-item.ordersDiscountAmount!)-item.loyalityRedeemed!+item.ordersDeliveryCharge!-item.roundOff!).toStringAsFixed(2)}',
                                               style: const TextStyle(
                                                color: AppColors.appColor,
                                                fontFamily: 'inter',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  InkWell(
                                    onTap: (){Get.to(OrderDetails(orderId: item.id,dacNo:item.dacno));},
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: AppColors.appLiteColor,
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(11),bottomRight:  Radius.circular(11)),

                                      ),
                                      child:  Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.event_note,color: Colors.white,size: 20,),
                                            const SizedBox(width: 10,),
                                            Text('view_bill_summary'.tr,style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'inter',
                                              fontSize: 14,
                                            ),)
                                          ],),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              ),
                            ),
                      noItemsFoundIndicatorBuilder: (_) => Center(child: Image.asset(AppImages.emptyOrder)),
                      firstPageProgressIndicatorBuilder:(_)=>Center(child: Image.asset(height:100,AppImages.appLogoImg)),
                      newPageProgressIndicatorBuilder: (_)=>Center(child: Image.asset(height:100,AppImages.appLogoImg)),
                      // noMoreItemsIndicatorBuilder: (_)=>Center(child: Image.asset(AppImages.appLogoImg)),
                      )
                      ),
                    ),);
                }
              ),
            )

          ],
        ),
      ),
    );
  }
}
