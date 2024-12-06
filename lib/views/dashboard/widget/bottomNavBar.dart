import 'package:ecom_books/constants/AppColors.dart';
import 'package:ecom_books/constants/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controllers/dashboard/BottomNavController.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({super.key});

  final BottomNavController controller = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(bottom: 5,top: 10),  // Adjust padding to control height
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(
                AppImages.dashHome,
                'Home',
                0,
              ),
              buildNavItem(
                AppImages.dashCategory,
                'Categories',
                1,
              ),
              buildNavItem(
                AppImages.dashOrders,
                'My orders',
                2,
              ),
              buildNavItem(
                AppImages.dashAccount,
                'Account',
                3,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildNavItem(String asset, String label, int index) {
    return InkWell(
      onTap: () {
        controller.changeIndex(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: controller.selectedIndex.value == index ? 25 : 22,
            height: controller.selectedIndex.value == index ? 25 : 22,
            child: SvgPicture.asset(
              asset,
              color: controller.selectedIndex.value == index
                  ? AppColors.appColor
                  : AppColors.liteGray,
            ),
          ),
          const SizedBox(height: 2), // Reduced space
          AnimatedOpacity(
            opacity: controller.selectedIndex.value == index ? 1.0 : 0.7,
            duration: Duration(milliseconds: 300),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'inter',
                color: controller.selectedIndex.value == index
                    ? Colors.black
                    : AppColors.grayColor,
                    fontWeight: controller.selectedIndex.value == index
                    ? FontWeight.bold  // Inter-Medium
                    : FontWeight.w500,
                fontSize: 12, // Smaller font size
              ),
            ),
          ),
          const SizedBox(height: 4), // Reduced space
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: controller.selectedIndex.value == index ? 50 : 40,
            height: 4, // Reduced height
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: controller.selectedIndex.value == index
                  ? AppColors.appColor
                  : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

// class BottomNavBar extends StatelessWidget {
//    BottomNavBar({super.key});
//
//   final BottomNavController controller = Get.put(BottomNavController());
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return BottomNavigationBar(
//         currentIndex: controller.selectedIndex.value,
//         onTap: (index) {
//           controller.changeIndex(index);
//         },
//         showUnselectedLabels: false,
//         backgroundColor: Colors.white,
//         elevation: 10,
//         showSelectedLabels: false,
//         items: [
//           // BottomNavigationBarItem(
//           //   activeIcon: Icon(Icons.home,color: AppColors.appColor,),
//           //   icon: Icon(Icons.home,color: Colors.grey,),
//           //   label: 'Home',
//           // ),
//           BottomNavigationBarItem(
//             icon: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SvgPicture.asset(
//                   AppImages.dashHome,
//                   color: controller.selectedIndex.value == 0 ? AppColors.appColor:AppColors.liteGray,
//                   width: 25, // Adjust width as needed
//                   height: 25, // Adjust height as needed
//                 ),
//                 Text('Home',style: TextStyle(fontFamily:'inter',color: controller.selectedIndex.value == 0 ? Colors.black:AppColors.grayColor ,fontWeight: FontWeight.bold,fontSize: 13),),
//                 SizedBox(height: 4), // Space between text and indicator
//                 Container(
//                   width: 50,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.rectangle,
//                     borderRadius: const BorderRadius.only(topLeft:  Radius.circular(10),topRight: Radius.circular(10)),
//                     color: controller.selectedIndex.value == 0 ? AppColors.appColor : Colors.transparent,
//                   ),
//                 ),
//               ],
//             ),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//
//                 SvgPicture.asset(
//                   AppImages.dashCategory,
//                   color: controller.selectedIndex.value == 1 ? AppColors.appColor:AppColors.liteGray,
//                   width: 25, // Adjust width as needed
//                   height: 25, // Adjust height as needed
//                 ),
//                 Text('Categories',style: TextStyle(fontFamily:'inter',color: controller.selectedIndex.value == 1 ? Colors.black:AppColors.grayColor ,fontWeight: FontWeight.bold,fontSize: 13)),
//                 SizedBox(height: 4), // Space between text and indicator
//                 Container(
//                   width: 50,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.rectangle,
//                     borderRadius: const BorderRadius.only(topLeft:  Radius.circular(10),topRight: Radius.circular(10)),
//
//                     color: controller.selectedIndex.value == 1 ? AppColors.appColor : Colors.transparent,
//                   ),
//                 ),
//               ],
//             ),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SvgPicture.asset(
//                   AppImages.dashOrders,
//                   color: controller.selectedIndex.value == 2 ? AppColors.appColor:AppColors.liteGray,
//                   width: 25, // Adjust width as needed
//                   height: 25, // Adjust height as needed
//                 ),
//                 Text('My orders',style: TextStyle(fontFamily:'inter',color: controller.selectedIndex.value == 2 ? Colors.black:AppColors.grayColor ,fontWeight: FontWeight.bold,fontSize: 13)),
//                 SizedBox(height: 4), // Space between text and indicator
//                 Container(
//                   width: 50,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.rectangle,
//                     borderRadius: const BorderRadius.only(topLeft:  Radius.circular(10),topRight: Radius.circular(10)),
//
//                     color: controller.selectedIndex.value == 2 ? AppColors.appColor : Colors.transparent,
//                   ),
//                 ),
//               ],
//             ),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: SizedBox(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SvgPicture.asset(
//                     AppImages.dashAccount,
//                     color: controller.selectedIndex.value == 3 ? AppColors.appColor:AppColors.liteGray,
//                     width: 25, // Adjust width as needed
//                     height: 25,// Adjust height as needed
//                   ),
//                   Text('Account',style: TextStyle(fontFamily:'inter',color: controller.selectedIndex.value == 3 ? Colors.black:AppColors.grayColor ,fontWeight: FontWeight.bold,fontSize: 13)),
//                   SizedBox(height: 4), // Space between text and indicator
//                   Container(
//                     width: 50,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.rectangle,
//                       borderRadius: const BorderRadius.only(topLeft:  Radius.circular(10),topRight: Radius.circular(10)),
//                       color: controller.selectedIndex.value == 3 ? AppColors.appColor : Colors.transparent,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             label: '',
//           ),
//         ],
//       );
//     });
//   }
// }
