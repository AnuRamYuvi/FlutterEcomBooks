import 'package:ecom_books/constants/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../constants/AppColors.dart';
import '../../../../../constants/AppImages.dart';
import '../../../../../models/dashboard/categories/productModel.dart';


class ImageBanner extends StatefulWidget {
  final List<ProductImages> productImage;
  const ImageBanner({Key? key, required this.productImage}) : super(key: key);

  @override
  State<ImageBanner> createState() => _HomebannerState();
}

class _HomebannerState extends State<ImageBanner> {
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.productImage.isNotEmpty?
        ImageMagnifier(imageUrl:  widget.productImage[currentIndex].productsImage!,):
        SizedBox(
          height: SizeConfig.defaultSize!*24,
          child: Center(
            child: Container(
              color: AppColors.appBgLiteColor,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        ),
        widget.productImage.length>1?
        SizedBox(
          width:double.infinity,
          height: 45,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.productImage.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15.0,top: 5),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        currentIndex=index;
                      });
                    },
                    child:Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: currentIndex == index ? AppColors.appColor : AppColors.liteGray,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8), // same as the container
                        child: Center(
                          child: CachedNetworkImage(
                            width: 40,
                            height: 40,
                            imageUrl: widget.productImage[index].productsImage!,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Center(
                              child: Container(
                                color: AppColors.appBgLiteColor,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: Image.asset(
                                AppImages.placeholder,
                              ),
                            ),
                            fadeInDuration: Duration.zero, // Remove fade-in animation
                            fadeOutDuration: Duration.zero,
                            placeholderFadeInDuration: Duration.zero,
                          ),
                        ),
                      ),
                    )

                  ),
                );
              }),
        ):Container(),
      ],);
  }


}
class ImageMagnifier extends StatefulWidget {
  final String imageUrl;
  const ImageMagnifier({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _ImageMagnifierState createState() => _ImageMagnifierState();
}

class _ImageMagnifierState extends State<ImageMagnifier> {
  Offset _magnifierPosition = Offset.zero;
  bool _isMagnifierVisible = false;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        children: <Widget>[
          GestureDetector(

            onPanUpdate: (details) {
              setState(() {
                _magnifierPosition = details.localPosition;
              });
            },
            onPanStart: (_) {
              setState(() {
                _isMagnifierVisible = true;
              });
            },
            onPanEnd: (_) {
              setState(() {
                _isMagnifierVisible = false;
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: SizedBox(
                width: double.infinity,
                child: CachedNetworkImage(
                  height: SizeConfig.defaultSize!*24,
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.fitHeight,
                  placeholder: (context, url) => Center(
                    child: Container(
                      color: AppColors.appBgLiteColor,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Image.asset(AppImages.placeholder),
                  ),
                  fadeInDuration: Duration.zero, // Remove fade-in animation
                  fadeOutDuration: Duration.zero,
                  placeholderFadeInDuration: Duration.zero,
                ),
              ),
            ),
          ),
          if (_isMagnifierVisible)
            Positioned(
              left: _magnifierPosition.dx - 95, // Center the magnifier horizontally
              top: _magnifierPosition.dy - 95,  // Center the magnifier vertically
              child: const RawMagnifier(
                decoration: MagnifierDecoration(
                  shape: CircleBorder(
                    side: BorderSide(color: AppColors.appColor, width: 1),
                  ),
                ),
                size: Size(170, 170),
                magnificationScale: 2,
              ),
            ),
        ],
      ),
    );
  }
}