import 'package:ecom_books/constants/AppImages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogLoader extends StatelessWidget {
  const CustomDialogLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Dialog(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: Center(
            child: ClipOval(
              child: Container(
                color: Colors.white,
                child: Image.asset(
                    height:100,AppImages.appLogoImg
                ),
              ),
            )));
  }
}
