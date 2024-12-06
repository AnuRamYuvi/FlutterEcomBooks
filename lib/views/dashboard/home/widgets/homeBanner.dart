import 'package:ecom_books/constants/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../constants/AppColors.dart';
import '../../../../constants/AppImages.dart';
import '../../../../models/dashboard/categories/productDetails.dart';
import '../../../../models/dashboard/home/homeModel.dart';

class Homebanner extends StatefulWidget {
  final List<GetBannerResult> data;
  const Homebanner({Key? key, required this.data}) : super(key: key);

  @override
  State<Homebanner> createState() => _HomebannerState();
}

class _HomebannerState extends State<Homebanner> {
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10,),
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            autoPlay: widget.data.length>1?true:false,
            viewportFraction: 1.0,
            onPageChanged: (index, _) {
              // Handle page change
              setState(() {
                currentIndex=index;
              });
            },
          ),
          items: widget.data.map<Widget>((item) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
              child: CachedNetworkImage(
                width: SizeConfig.screenWidth,
                height: 150,
                imageUrl: item.bannerImageUrl!,
                fit: BoxFit.fill,
                placeholder: (context, url) => Center(
                  child: Container(color: AppColors.appBgLiteColor,height: double.infinity,width: double.infinity,)
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
              //   width: SizeConfig.screenWidth,
              //   height: 150,
              //   item.bannerImageUrl!,
              //   fit: BoxFit.fill,
              // ),
            );
          }).toList(),
        ),
        SizedBox(height: 10,),
        SizedBox(
          height: 16,
          child: AnimatedSmoothIndicator(
            activeIndex: currentIndex,
            count: widget.data.length,
            effect: const WormEffect(
              dotWidth: 10,
              dotHeight: 10,
              activeDotColor: AppColors.appColor,
            ),
          ),
        ),
      ],);
  }


}
