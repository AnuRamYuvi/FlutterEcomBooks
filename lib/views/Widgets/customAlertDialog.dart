import 'package:flutter/material.dart';

import '../../constants/AppColors.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String onConfirmText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomAlertDialog({super.key,
    required this.title,
    required this.content,
    required this.onConfirmText,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                    onTap:onCancel,
                    child: Icon(Icons.highlight_remove,color: Colors.black,size: 25,))
              ],
            ),
            SizedBox(height: 10),
            Text(content,style: TextStyle(color: AppColors.grayColor,fontSize: 14),),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // TextButton(
                //   onPressed: onCancel,
                //   child: Text('Cancel'),
                // ),
                ElevatedButton(
                    onPressed: onConfirm,
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
                        onConfirmText,
                      style: const TextStyle(
                          fontFamily: 'inter',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
