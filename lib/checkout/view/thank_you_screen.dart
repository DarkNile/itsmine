import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsmine/constants/colors.dart';
import 'package:itsmine/home/view/home_screen.dart';
import 'package:itsmine/widgets/custom_button.dart';
import 'package:itsmine/widgets/custom_text.dart';
import 'package:lottie/lottie.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({
    super.key,
    required this.orderId,
    required this.email, this.isReturn = false,
  });

  final int orderId;
  final String email;
  final bool isReturn ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
          top: 32,
          bottom: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.offAll(() => const HomePage());
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Center(
                  child: CustomText(
                    text: isReturn ? 'confirmReturn'.tr :'confirmByEmail'.tr,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Center(
                  child: CustomText(
                    text: isReturn ? "" : email,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/preparing_order.json',
                    width: 400,
                    height: 400,
                  ),
                  const CustomText(
                    text: 'جاري تجهيز طلبك',
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      text: isReturn ? "returnNumber".tr: 'orderNumber'.tr,
                      color: brownishGrey,
                      fontSize: 10,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    CustomText(
                      text: orderId.toString(),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomText(
                  text: 'trackYourOrder'.tr,
                  color: brownishGrey,
                  fontSize: 10,
                ),
              ],
            ),
            CustomButton(
                onPressed: () {
                  Get.offAll(() => const HomePage(
                        pageIndex: 2,
                      ));
                },
                title: 'myOrdersHistory'.tr),
          ],
        ),
      ),
    );
  }
}
