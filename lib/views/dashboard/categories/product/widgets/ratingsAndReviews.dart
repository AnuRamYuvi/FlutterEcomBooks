import 'package:ecom_books/constants/AppImages.dart';
import 'package:ecom_books/models/dashboard/categories/ratings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/AppColors.dart';
import '../../../../../controllers/dashboard/categories/product/ratingsAndReviewsController.dart';
import '../../../../Widgets/customStarRatings.dart';

class RatingsAndReviews extends StatelessWidget {
  final Ratings? ratingsDetails;
  final bool edit;
  final String productId;
  final String? productName;
  RatingsAndReviews({super.key, required this.ratingsDetails,required this.edit, required this.productId, required this.productName});

  final RatingsAndReviewsController ratingsAndReviewsController =Get.put(RatingsAndReviewsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RatingsAndReviewsController>(
      initState: (_){
        ratingsAndReviewsController.itsMax=false;
        ratingsAndReviewsController.ratings=0;
      },
      builder: (controller) {
        return GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: SizedBox(
            width: double.infinity,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ratingsDetails!=null?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text('overall_ratings_and_reviews'.tr,style: const TextStyle(color:AppColors.black,fontWeight: FontWeight.bold,fontSize: 14),),
                  const SizedBox(height: 5,),
                  Text('customer_rating'.tr,style: const TextStyle(color:AppColors.grayColor,fontWeight: FontWeight.bold,fontSize: 13),),
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomStarRatings(indicator:true,rating:controller.parseOverallRating(ratingsDetails!.overallRating),itemSize: 18,ratingsAndReviewsController: null,),
                      Text('${ratingsDetails!.overallRating} ${'out_of'.tr} 5',style: const TextStyle(color:AppColors.black,fontWeight: FontWeight.w500,fontSize: 14),),
                    ],),
                  Text('${ratingsDetails!.outOf} ${'real_users'.tr}',style: const TextStyle(color:AppColors.grayColor,fontWeight: FontWeight.normal,fontSize: 11),),
                  const SizedBox(height: 5,),
                  Text('customer_reviews'.tr,style: const TextStyle(color:AppColors.grayColor,fontWeight: FontWeight.bold,fontSize: 13),),
                  const SizedBox(height: 5,),
                  ...List<Widget>.generate(
                   controller.itsMax?ratingsDetails!.reviews!.length:ratingsDetails!.reviews!.length<6?ratingsDetails!.reviews!.length:5,
                  (index) {
                    Reviews reviewsData= ratingsDetails!.reviews![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      SizedBox(
                        width:double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Image.asset(AppImages.placeholder,height: 70,width: 70,),
                            const Icon(CupertinoIcons.person_crop_circle_fill,size: 50,color: AppColors.grayColor300,),
                            const SizedBox(width: 10,),
                             Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(reviewsData.customersName!,style: TextStyle(color:AppColors.black,fontWeight: FontWeight.bold,fontSize: 13),),
                                // Text('Location : Coimbatore',style: TextStyle(color:AppColors.grayColor,fontWeight: FontWeight.w500,fontSize: 13),),
                                Text('Reviewed On ${controller.formatDateTime(reviewsData.createdAt)}',style: TextStyle(color:AppColors.grayColor,fontWeight: FontWeight.w500,fontSize: 13),),
                                CustomStarRatings(indicator:true,rating:reviewsData.rating!,itemSize: 15,ratingsAndReviewsController:null),

                                // const Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     CustomStarRatings(indicator:true,rating:2.5,itemSize: 15,),
                                //     SizedBox(width: 10,),
                                //     Text('15-jun-2025',style: TextStyle(color:AppColors.grayColor,fontWeight: FontWeight.normal,fontSize: 14),),
                                //   ],),
                              ],)
                          ],
                        ),
                      ),
                      const SizedBox(height: 5,),
                      // const Text('Best in this range',style: TextStyle(color:AppColors.black,fontWeight: FontWeight.bold,fontSize: 13),),
                        reviewsData.comments!=null &&reviewsData.comments!.trim()!=''?
                        Text(reviewsData.comments!,style: TextStyle(color:AppColors.black,fontWeight: FontWeight.normal,fontSize: 13),):Container(),
                        const SizedBox(height: 8,),
                        const Divider(color: AppColors.appBgLiteColor,height: 1,thickness: 1,),
                        const SizedBox(height: 8,),
                      ],);
                  }),

                  ratingsDetails!.reviews!.length<6?Container():
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            controller.itsMax=!controller.itsMax;
                            controller.update();
                          },
                          child: Text(controller.itsMax?'Collapse reviews':'View all reviews',style: TextStyle(color:AppColors.black,fontWeight: FontWeight.w500,fontSize: 13),)),
                      ],
                    ),
                  ),
                   SizedBox(height: ratingsDetails!.reviews!.length>5?10:2,),
                    ],
                  ):Container(),

                  edit?Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Text('write_your_review_and_ratings'.tr,style: const TextStyle(color:AppColors.black,fontWeight: FontWeight.bold,fontSize: 13),),
                    const SizedBox(height: 5,),
                     CustomStarRatings(indicator:false,rating:controller.ratings,itemSize: 25,ratingsAndReviewsController:controller),
                    const SizedBox(height: 10,),
                    // TextField(
                    //   maxLength: 50,
                    //   controller: controller.reviewTitleController,
                    //   style: const TextStyle(
                    //     fontSize: 13, // Change this value to adjust the text size
                    //   ),
                    //   decoration: InputDecoration(
                    //     hintText: 'Write your review title',
                    //     hintStyle:  const TextStyle(
                    //         color: Colors.grey,fontSize: 13
                    //     ),
                    //     counterText: "",
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //       borderSide:const BorderSide(color: AppColors.appBgLiteColor,width: 1),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //       borderSide: const BorderSide(
                    //         color: AppColors.appBgLiteColor,
                    //         width: 1,
                    //       ),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //       borderSide: const BorderSide(
                    //         color: AppColors.appColor,
                    //         width: 2,
                    //       ),
                    //     ),
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //
                    //     // Optional: background color
                    //     contentPadding: const EdgeInsets.symmetric(
                    //         horizontal: 10, vertical: 10),
                    //   ),
                    // ),
                    // const SizedBox(height: 10,),
                    TextField(
                      controller: controller.reviewTitleContentController,
                      maxLines: 6,
                      minLines: 4,
                      autofocus: false,
                      style: const TextStyle(
                        fontSize: 13, // Change this value to adjust the text size
                      ),
                      decoration: InputDecoration(
                        hintText: 'Write your thoughts...',
                        hintStyle:  const TextStyle(
                            color: Colors.grey,fontSize: 13
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:const BorderSide(color: AppColors.appBgLiteColor,width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.appBgLiteColor,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.appColor,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        // Optional: background color
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                      ),
                    ),
                    controller.ratings>0?
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.appColor),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          15.0), // Adjust the radius as needed
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                 FocusScope.of(context).unfocus();
                                 controller.submitRatings(productId,productName??'');
                                },
                                child: Text(
                                  'submit'.tr,
                                  style: TextStyle(
                                      fontFamily: 'inter', color: Colors.white),
                                )),
                          ],
                        ),
                    ):Container(),
                    const SizedBox(height: 10,),
                  ],):Container()
                ]),
          ),
        );
      }
    );
  }
}
