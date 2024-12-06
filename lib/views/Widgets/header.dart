import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/AppColors.dart';
import '../dashboard/widget/customCartIcon.dart';

class Header extends StatelessWidget {
  final String title ;
  final bool backBtn;
  final bool cartBtn;
  final VoidCallback? onBack;
  const Header({super.key, required this.title,required this.backBtn,required this.cartBtn,this.onBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: kToolbarHeight,
          color: Colors.white, // Equivalent to ?actionBarSize
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                backBtn? IconButton(
                  icon: const Icon(Icons.arrow_circle_left_outlined,color: Colors.black,size:30,),
                  onPressed:onBack ?? () {
                    Get.back();
                  },
                ):Container(width: 40),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(fontFamily:'inter',
                      // fontFamily: 'InterMedium',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                ),
                cartBtn? const Padding(
                  padding: EdgeInsets.only(left: 8.0,right: 8),
                  child: CustomCartIcon(),
                ):Container(width: 30,),
              ],
            ),
          ),
        ),
        const Divider(color: AppColors.appBgLiteColor,height: 8,thickness: 8,)
      ],
    );
  }
}