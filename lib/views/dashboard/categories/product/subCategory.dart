import 'package:ecom_books/controllers/dashboard/categories/product/subCategoryController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/AppColors.dart';
import '../../../../constants/AppImages.dart';
import '../../../../constants/Constants.dart';

class SubCategory extends StatelessWidget {
  final int? categoryID;
  final int? subCategoryID;
   SubCategory({super.key, required this.categoryID, required this.subCategoryID});
  final SubCategoryController subCategoryController =Get.put(SubCategoryController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubCategoryController>(
      initState: (_){
        subCategoryController.getCategory(categoryID!, subCategoryID!);
      },
      builder: (controller) {
        return controller.subCategory!=null?
        ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: controller.subCategory!.length,
          itemBuilder: (context, index) {
            String? name='';
            String? image='';
            int? count=0;
            if(index==0){
               name=controller.subCategory![index].all!;
               image=controller.subCategory![index+1].subcategoryImage!;
               count=controller.subCategory![index].count??0;
            }else{
               name=controller.subCategory![index].subcategoryName!;
               image=controller.subCategory![index].subcategoryImage!;
               count=controller.subCategory![index].productsCount??0;
            }
            if(image==null || image.trim().isEmpty){
              image='https://naturefert.com/wp-content/uploads/2021/08/milo-axladi.png';
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: count==0?0.3:1.0,
                  child: SizedBox(
                  // decoration: BoxDecoration(
                  // border: Border(
                  // left: BorderSide(color: controller.selectedIndex == index ? AppColors.appColor:AppColors.white!, width: controller.selectedIndex == index ?6:0),
                  // ),
                  // ),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                        width:  controller.selectedIndex == index ?5:0,
                        height: 81,
                        decoration: BoxDecoration(
                        color: controller.selectedIndex == index ? AppColors.appColor:AppColors.white!,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),topRight:  Radius.circular(5)),
                        // border: Border(right: BorderSide(color: controller.selectedIndex == index ? AppColors.appColor:AppColors.white!, width: controller.selectedIndex == index ?6:0),),
                        ),),
                        InkWell(
                          onTap: (){
                            if(count!=0) {
                              controller.pressSubCategory(index);
                            }
                          },
                          child: SizedBox(
                            width: 75,
                            child: Column(
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: controller.selectedIndex == index ? AppColors.appLiteColor: AppColors.appBgLiteColor,
                                    gradient: Constants.isBgGradients ?
                                    LinearGradient(
                                      colors: controller.selectedIndex == index ?[ AppColors.appLiteColor, AppColors.white]:[ AppColors.appBgLiteColor, AppColors.white],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      // begin: Alignment.topLeft,
                                      // end: Alignment.bottomRight,
                                    ):null,

                                    borderRadius: BorderRadius.circular(50.0),
                                  ),

                                  child: ClipRRect(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CachedNetworkImage(
                                        height: 40,
                                        width: 40,
                                        imageUrl: image,
                                        placeholder: (context, url) => Center(
                                          child: Image.asset(
                                            AppImages.placeholder,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>Center(
                                          child: Image.asset(
                                            AppImages.placeholder,
                                          ),
                                        ),
                                        fadeInDuration: Duration.zero, // Remove fade-in animation
                                        fadeOutDuration: Duration.zero,
                                        placeholderFadeInDuration: Duration.zero,
                                      ),
                                      // Image.network(image,
                                      //   width: 40,height: 40,fit: BoxFit.cover,),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 1.0,right: 2),
                                  child: Text(name,textAlign:TextAlign.center,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10),),
                                ),
                                const SizedBox(height: 2,),
                                Text('${count} items',textAlign:TextAlign.center,style: const TextStyle(color: AppColors.grayColor,fontWeight: FontWeight.bold,fontSize: 9),),

                              ],),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Divider(color: AppColors.appBgLiteColor,height: 1,thickness: 1,),
                )
              ],
            );
          },
        ):Container();
      }
    );


  }
}

