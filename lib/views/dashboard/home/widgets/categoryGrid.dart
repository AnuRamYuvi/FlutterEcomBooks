import 'package:ecom_books/constants/AppColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constants/AppImages.dart';
import '../../../../constants/Constants.dart';
import '../../../../constants/size_config.dart';
import '../../../../models/dashboard/home/homeModel.dart';
import '../../categories/product/ProductMainPage.dart';

class CategoryGrid extends StatelessWidget {
  final List<GetCategoryResult> categories;
  final List<SubCategories> subCategories;
  final int type ;
  const CategoryGrid({super.key, required this.categories,required this.subCategories,required this.type});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:SizeConfig.orientation == Orientation.portrait ? 3 : 4,
            mainAxisSpacing: 2,
            crossAxisSpacing: 15,
            childAspectRatio: 0.770,
          ),
          itemCount: type==1?categories.length:subCategories.length,
          itemBuilder: (context, index) {
            String productName= type==1?categories[index].categoryName!:subCategories[index].subcategoryName!;
            String productImg= type==1?categories[index].categoryImage!:subCategories[index].subcategoryImage!;

            // bg color
            final colorIndex = index % AppColors.categoryBgColors.length;
            final selectedColor = AppColors.categoryBgColors[colorIndex];

            // gradient color
             final gradientIndex = index % AppColors.categoryBgGradients.length;
             final selectedGradient = AppColors.categoryBgGradients[gradientIndex];

            return AspectRatio(
              aspectRatio: 0.783,
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: (){
                  Get.to(()=>ProductMainPage(categoryID:type==1?categories[index].id:subCategories[index].categoryId,subCategoryID:type!=1?subCategories[index].id:0));
                  //navigateDetails(products![index].mainId.toString(),context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedColor,
                    gradient: Constants.isBgGradients? LinearGradient(
                      colors: selectedGradient,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      // begin: Alignment.topLeft,
                      // end: Alignment.bottomRight,
                    ):null,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                            imageUrl: productImg,
                            fit:BoxFit.contain,
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
                          // Image.network(
                          //     productImg.trim().isNotEmpty?productImg.trim():'https://snowch.com/images/empty.jpg',
                          //             fit: BoxFit.contain,
                          //           ),
                        ),
                      ),
                      Text(
                        productName,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily:'inter',
                          fontSize:  SizeConfig.defaultSize! * 1.2, fontWeight: FontWeight.bold//16
                        ),
                      ),
                      //  SizedBox(height: defaultSize / 2),
                      //  Text("\$${product.price}"),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            );

          },
        ),
      ],
    );
  }
}
