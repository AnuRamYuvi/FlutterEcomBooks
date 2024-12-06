import 'package:ecom_books/constants/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../models/dashboard/home/homeModel.dart';
import 'categoryGrid.dart';

class SubCategoryGrid extends StatelessWidget {
  final List<GetHomeCategoryResult> data;

  const SubCategoryGrid({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final category = data[index];
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 5, // Width of the vertical divider
                      height: 24  , // Height of the vertical divider

                      decoration: BoxDecoration(
                        color: AppColors.appColor,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(4),bottomRight: Radius.circular(4)),
                      ),
                      // Margin around the vertical divider
                    ),
                  SizedBox(width: 5,),
                  Text(category.categoryName!,style: TextStyle(fontFamily:'inter',fontWeight: FontWeight.bold,fontSize: 16),),
                ],),
                SizedBox(height: 10,),
                CategoryGrid( categories: [], subCategories: category.subCategories!,type: 2,),
              ],);
          },
        )
      ],);
  }
}
