import 'package:ecom_books/constants/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../constants/AppStrings.dart';
import '../../../controllers/dashboard/widgetController/customBottomBarController.dart';
import '../myOrders/myCartPage.dart';

class CustomBottomBar extends StatelessWidget {
  CustomBottomBar({super.key});

  final CustomBottomBarController controller = Get.put(CustomBottomBarController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.white,
        child: GetBuilder<CustomBottomBarController>(builder: (controller) {
          return controller.cartCount != null &&
                  controller.cartCount!.cartTotalItems != null &&
                  controller.cartCount!.cartTotalItems! > 0
              ? Container(
                  height: 60,
                  decoration: const BoxDecoration(
                      color: AppColors.appLiteColor1,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${controller.cartCount!.cartTotalItems} ${'items_in_cart'.tr}",
                              style: TextStyle(
                                  fontFamily: 'inter',
                                  color: AppColors.grayColor,fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${AppStrings.rupeeSymbol} ${controller.cartCount!.cartTotal!.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontFamily: 'inter',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                controller.cartCount!.cartTotalSavings != null &&
                                        controller.cartCount!.cartTotalSavings! > 0
                                    ? Row(
                                        children: [
                                          SizedBox(
                                            width: 8,
                                          ),
                                          const Icon(
                                            Icons.circle,
                                            size: 8.0, // Adjust the size of the dot
                                            color: Colors
                                                .white, // Adjust the color of the dot
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                "${AppStrings.rupeeSymbol} ${controller.cartCount!.cartTotalSavings!.toStringAsFixed(2)} Saved",
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    color: AppColors.appColor,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : Container(),
                              ],
                            ),
                          ],
                        ),
                        TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.appColor),
                              shape:
                                  MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12.0), // Adjust the radius as needed
                                ),
                              ),
                            ),
                            onPressed: () {
                              Get.to(MyCartPage());
                            },
                            child: Text(
                              'view_cart'.tr,
                              style: TextStyle(
                                  fontFamily: 'inter', color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                )
              : Container(
                  height: 0,
                );
        }),
      ),
    );
  }
}
