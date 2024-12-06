import 'package:ecom_books/constants/AppColors.dart';
import 'package:ecom_books/views/dashboard/categories/categories.dart';
import 'package:ecom_books/views/dashboard/home/homePage.dart';
import 'package:ecom_books/views/dashboard/myAccount/myAccount.dart';
import 'package:ecom_books/views/dashboard/myOrders/myOrders.dart';
import 'package:ecom_books/views/dashboard/widget/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/dashboard/BottomNavController.dart';

class MainScreen extends StatelessWidget {
   MainScreen({super.key});
  final BottomNavController controller = Get.put(BottomNavController());

   final List<Widget> _pages = [
     HomePage(),
     CategoriesPage(),
     MyOrders(),
     MyAccount()
   ];

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        if (controller.selectedIndex.value==0) {
          final now = DateTime.now();
          if (controller.lastPressedAt == null ||
              now.difference(controller.lastPressedAt!) >
                  Duration(seconds: controller.exitTimeInSeconds)) {
            controller.lastPressedAt = now;
            controller.update();
            Get.snackbar('Exit ?','Press back again to exit',
              duration: const Duration(seconds: 2), snackPosition: SnackPosition.BOTTOM,);
            return false; // Do not exit
          }
          return true; // Exit the app
        }else{
          controller.changeIndex(0);
        return false;
        }
      },
      child: Scaffold(
        body: Obx(() {
          return _pages[controller.selectedIndex.value];
        }),

        bottomNavigationBar: CustomBottomNavBar(),
      ),
    );
  }
}

