import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsmine/constants/colors.dart';
import 'package:itsmine/product/models/product.dart';
import 'package:itsmine/widgets/custom_loading_widget.dart';
import 'package:itsmine/widgets/custom_text.dart';

class CustomReturnItem extends StatelessWidget {
  const CustomReturnItem({
    super.key,
 required this.image, required this.name, required this.size, required this.price, required this.quantity,

  });


  final String? image;
  final String name,size;
  final String price;

  final String quantity;


  @override
  Widget build(BuildContext context) {  
    bool isChecked = true ;

    return Container(
      height:  MediaQuery.of(context).size.height *0.16,
      width: MediaQuery.of(context).size.width*0.7 ,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
    
        children: [
          // Checkbox(value: isChecked, onChanged: (value){
          //   isChecked = value! ;
          // }),
          SizedBox(),
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: CachedNetworkImage(
                imageUrl: image!,
                placeholder: (context, url) {
                  return const CustomLoadingWidget();
                },
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name,
                  height: 2,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomText(
                  text: price.toString(),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    CustomText(
                      text: 'المقاس',
                      height: 2,
                      color: brownishGrey,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const CustomText(
                      text: ':',
                      height: 2,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    CustomText(
                      text: size,
                      height: 2,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomText(
                      text: 'quantity'.tr,
                      height: 2,
                      color: brownishGrey,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const CustomText(
                      text: ':',
                      height: 2,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    CustomText(
                      text: quantity.toString(),
                      height: 2,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
