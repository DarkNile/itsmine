import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsmine/product/models/product.dart';
import 'package:itsmine/widgets/custom_text.dart';

class RatingReviewScreen extends StatelessWidget {
  const RatingReviewScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        text: 'noReviews'.tr,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
