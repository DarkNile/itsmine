import 'package:flutter/material.dart';
import 'package:itsmine/utils/app_util.dart';
import 'package:itsmine/widgets/custom_text.dart';

class CustomBodyTitle extends StatelessWidget {
  const CustomBodyTitle({
    super.key,
    required this.title,
    this.fontSize,
    this.fontWeight,
  });

  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 9,
        right: AppUtil.rtlDirection(context) ? 28 : 0,
        left: AppUtil.rtlDirection(context) ? 0 : 28,
      ),
      width: MediaQuery.of(context).size.width,
      height: 40,
      color: Colors.black,
      child: CustomText(
        text: title,
        fontSize: fontSize ?? 14,
        color: Colors.white,
        fontWeight: fontWeight ?? FontWeight.w300,
      ),
    );
  }
}
