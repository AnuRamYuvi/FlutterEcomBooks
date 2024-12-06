import 'package:ecom_books/constants/AppColors.dart';
import 'package:ecom_books/views/Widgets/header.dart';
import 'package:ecom_books/views/dashboard/categories/product/productListView.dart';
import 'package:ecom_books/views/dashboard/categories/product/productPageHeader.dart';
import 'package:ecom_books/views/dashboard/categories/product/subCategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../widget/customBottomBar.dart';

class ProductMainPage extends StatelessWidget {
  final int? categoryID;
  final int? subCategoryID;

  const ProductMainPage({super.key, required this.categoryID, required this.subCategoryID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.appBgLiteColor,
          child: Column(
            children: [
              // Header(title: "sdfsd", backBtn: true, cartBtn: true),
              ProductPageHeader(categoryID:categoryID),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight:Radius.circular(10) )
                      ),
                      width: 80,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SubCategory(categoryID:categoryID,subCategoryID:subCategoryID),
                      ),
                    ),
                    Expanded(
                      child: ProductListView(categoryID:categoryID,subCategoryID:subCategoryID,search:null)
                    ),

                ],),
              ),
              const Divider(color: AppColors.appBgLiteColor,height: 8,thickness: 8,)

            ],),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
