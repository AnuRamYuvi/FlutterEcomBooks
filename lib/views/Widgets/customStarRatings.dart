import 'package:ecom_books/constants/AppColors.dart';
import 'package:ecom_books/constants/AppImages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../controllers/dashboard/categories/product/ratingsAndReviewsController.dart';

class CustomStarRatings extends StatelessWidget {
  final bool indicator;
  final double rating;
  final double itemSize;
  final RatingsAndReviewsController? ratingsAndReviewsController;
  const CustomStarRatings({super.key, required  this.indicator, required this.rating, required this.itemSize, required this.ratingsAndReviewsController});

  @override
  Widget build(BuildContext context) {
    return
      // indicator?
    RatingBar(
      initialRating: rating,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: itemSize,
      ratingWidget: RatingWidget(
        full: Image.asset(AppImages.starFull),
        half: Image.asset(AppImages.starHalf),
        empty:Image.asset(AppImages.starEmpty),
      ),
      ignoreGestures: indicator,
      // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      onRatingUpdate: (ratings) {
        if(!indicator) {
          ratingsAndReviewsController!.ratings = ratings;
          ratingsAndReviewsController!.update();
        }
      },
    );
    // RatingBarIndicator(
    //   rating: rating,
    //   itemBuilder: (context, index) => const Icon(
    //     CupertinoIcons.star_fill,
    //     color: AppColors.red,
    //   ),
    //   itemCount: 5,
    //   itemSize: 12,
    //   direction: Axis.horizontal,
    // )
    //     :RatingBar.builder(
    //   initialRating: rating,
    //   minRating: 0,
    //   direction: Axis.horizontal,
    //   allowHalfRating: true,
    //   itemCount: 5,
    //   itemSize: 15,
    //   maxRating: 5.0,
    //   itemBuilder: (context, _) => const Icon(
    //     CupertinoIcons.star_fill,
    //     color: AppColors.red,
    //   ),
    //   onRatingUpdate: (rating) {
    //     print(rating);
    //   },
    // );
  }
}
