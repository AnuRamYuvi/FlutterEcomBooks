import 'package:ecom_books/constants/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomDialog extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String orderId;
  final String content;
  final String confirmText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final bool onCloseBtn;
  CustomDialog({
    required this.imageUrl,
    required this.title,
    required this.orderId,
    required this.content,
    required this.onConfirm,
    required this.confirmText,
    required this.onCancel,
    required this.onCloseBtn,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      // backgroundColor: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            onCloseBtn ?Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
               InkWell(
                   onTap:onCancel,
                   child: Icon(Icons.highlight_remove,color: Colors.black,size: 25,))
             ],):Container(),
            orderId==''?Image.asset(imageUrl,height: 150,):
            Lottie.asset(
              imageUrl,
              width: 150,
              height: 150,
              fit: BoxFit.fill,
            ),
            // SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(fontFamily:'inter',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(content,textAlign: TextAlign.center,style: TextStyle(fontFamily:'inter',color: AppColors.grayColor,fontSize: 13),),
            SizedBox(height: 10.0),

              orderId!=''?Column(
              children: [
              Text("Order Number",style: TextStyle(color: AppColors.grayColor,fontWeight: FontWeight.bold,fontSize: 14),),
                SizedBox(height: 5.0),
              Text(orderId,style: TextStyle(color: AppColors.grayColor,fontWeight: FontWeight.bold,fontSize: 16),),
              SizedBox(height: 10.0),
            ],):Container(),

            TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.appColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                    ),
                  ),
                ),
                onPressed:onConfirm,
                child: Text(confirmText,style: TextStyle(fontFamily:'inter',color: Colors.white),))
          ],
        ),
      ),
    );
  }
}