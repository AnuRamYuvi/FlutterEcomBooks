import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom_books/constants/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants/AppColors.dart';
import '../../constants/AppImages.dart';
class LoginSlider extends StatefulWidget {
  const LoginSlider({super.key});

  @override
  State<LoginSlider> createState() => _LoginSliderState();
}

class _LoginSliderState extends State<LoginSlider> {
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 285,
            autoPlay: true,
            viewportFraction: 1.0,
            onPageChanged: (index, _) {
              // Handle page change
              setState(() {
                currentIndex=index;
              });

            },
          ),
          items: [
            buildListItem(AppImages.loginBanner1, 'login_content1'.tr, 'login_cont1_msg1'.tr),
            buildListItem(AppImages.loginBanner2, 'login_content2'.tr, 'login_cont2_msg1'.tr),
            // buildListItem(AppImages.loginBanner3, 'login_content3'.tr, 'login_cont3_msg1'.tr, 'login_cont3_msg2'.tr),
          ],
        ),
        SizedBox(height: 10,),
        SizedBox(
          height: 16,
          child: AnimatedSmoothIndicator(
            activeIndex: currentIndex,
            count: 3,
            effect: const WormEffect(
              dotWidth: 10,
              dotHeight: 10,
              activeDotColor: AppColors.appColor,
            ),
          ),
        ),
      ],);
  }
  Widget buildListItem(String imageAsset, String title, String message1) {
    return Column(
      children: [
        SizedBox(
            height:215,
            child: Image.asset(imageAsset,fit: BoxFit.fill,)),
        Text(title, style: TextStyle(fontFamily:'inter',fontSize: 18, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
        SizedBox(
          width: SizeConfig.screenWidth,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 5),
              child: Text(message1, style: TextStyle(fontFamily:'inter',fontSize: 15),textAlign: TextAlign.center,),
            )),
        // Text(message2, style: TextStyle(fontFamily:'inter',fontSize: 16)),
      ],
    );
  }

}
