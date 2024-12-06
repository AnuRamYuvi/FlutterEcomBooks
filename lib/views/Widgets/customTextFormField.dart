import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../dashboard/widget/horizontalDashLine.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final RxnString errorText;
  final TextInputType keyboardType;
  final int maxLength;
  final IconData icon;
  final VoidCallback onValidate;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.errorText,
    required this.keyboardType,
    required this.maxLength,
    required this.icon,
    required this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                icon,
                size: 25,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                width: 1, // Width of the vertical divider
                height: 40, // Height of the vertical divider
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: TextFormField(
                maxLength: maxLength,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: "",
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontFamily: 'inter',
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                style: const TextStyle(
                  fontFamily: 'inter',
                  color: Colors.black,
                  fontSize: 16,
                ),
                controller: controller,
                onChanged: (value) => onValidate(),
              ),
            ),
          ],
        ),
        const DashedHorizontalDivider(
          color: Colors.grey,
          width: double.infinity,
          dashWidth: 10,
          dashSpace: 0,
        ),
        Obx(() {
          if (errorText.value != null) {
            return Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    errorText.value!,
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        }),
      ],
    );
  }
}
