import 'package:flutter/material.dart';
import 'package:itsmine/checkout/view/thank_you_screen.dart';
import 'package:itsmine/constants/colors.dart';
import 'package:itsmine/profile/controllers/profile_controller.dart';
import 'package:itsmine/return/controller/return_controller.dart';
import 'package:itsmine/return/view/widget/custom_return_item.dart';
import 'package:itsmine/widgets/custom_header.dart';
import 'package:get/get.dart';
import 'package:itsmine/widgets/custom_text.dart';
import 'package:itsmine/widgets/custom_text_field.dart';
import '../../product/models/product.dart';
import '../../widgets/custom_body_title.dart';
import '../../widgets/custom_button.dart';

class OrderInfoScreen extends StatefulWidget {
  const OrderInfoScreen({
    super.key,
    required this.returnController,
  });

  final ReturnController returnController;

  @override
  State<OrderInfoScreen> createState() => _OrderInfoScreenState();
}

class _OrderInfoScreenState extends State<OrderInfoScreen> {
  final _returnController = Get.put(ReturnController());
  final _profileController  = Get.put(ProfileController());

  final _ReasonController = TextEditingController();
  List<Product>? selectedProduct = [];

  int? returnId ;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomHeader(title: 'orderInfo'.tr),
        body: ListView(
          children: [
            CustomBodyTitle(title: 'orderInfo'.tr),
            Padding(
              padding:
                  EdgeInsets.only(top: 19, right: 19, left: 19, bottom: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(
                        text:"${'orderNumber'.tr} : ",
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                      ),
                      CustomText(
                        text: '${widget.returnController.returnOrder!.orderId}',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      Spacer(),
                      CustomText(
                        text:"${'dateOrdered'.tr} : ",
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                      ),
                      CustomText(
                        text:
                            '${widget.returnController.returnOrder!.dateOrdered.toString().substring(0, 10)}',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                      width: width * 0.77,
                      child: const  Divider(
                        color: darkGrey,
                        thickness: 1,
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomText(
                    text: 'customerInformation'.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  CustomText(
                    text:
                       // '${widget.returnController.returnOrder!.firstName.toString()} ${widget.returnController.returnOrder!.lastName.toString()}',
                      '${_profileController.user.value.firstName!} ${_profileController.user.value.lastName!}',
                    fontWeight: FontWeight.w300,
                    fontSize: 13,
                    color: brownishGrey,
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  CustomText(
                    text: "0${widget.returnController.returnOrder!.phone}",
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),

                  //  SizedBox(height: 16,),
                ],
              ),
            ),
            const Divider(
              color: darkGrey,
              thickness: 10,
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 19, right: 19, left: 19, bottom: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text:
                      '${'purchase'.tr} ( ${widget.returnController.returnOrder!.products!.length.toString()} )',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    color: darkGrey,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomText(
                    text: 'selectPurchases'.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: vermillion,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: //10,
                        widget.returnController.returnOrder!.products!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 28,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Checkbox(
                              value: widget.returnController.returnOrder!
                                  .products![index].isSelected,
                              onChanged: (value) {
                                setState(() {
                                  widget.returnController.returnOrder!
                                      .products![index].isSelected = value!;

                                      if (widget.returnController.returnOrder!.products![index].isSelected ) {
                                        selectedProduct!.add(widget.returnController.returnOrder!.products![index]);
                                      } else {
                                        selectedProduct!.remove(widget.returnController.returnOrder!.products![index]);
                                      }

                                });

                                print(selectedProduct!.length);
                              }),
                          CustomReturnItem(
                              image: //'https://itsmines.store/image/cache/catalog/19137/19137%20(3)-500x500.jpg',
                                  widget.returnController.returnOrder!
                                  .products![index].image,
                              name: widget.returnController.returnOrder!
                                  .products![index].name
                                  .toString(),
                              size: widget.returnController.returnOrder!
                                  .products![index].option![0].value.toString(),
                              price: widget.returnController.returnOrder!
                                  .products![index].price
                                  .toString(),
                              quantity: widget.returnController.returnOrder!
                                  .products![index].quantity
                                  .toString()),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 35,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  CustomText(
                    text: 'selectReasonForReturn'.tr,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const CustomText(
                    text: '*',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: vermillion,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 33,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: CustomText(
                text: 'chooseOneReasonsReturn'.tr,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(() {
              return Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: _returnController.returnReason.value,
                      onChanged: ((newValue) {
                        _returnController.returnReason.value = newValue!;
                        print(_returnController.returnReason.value);
                        _returnController.isReasonSelected.value = true;
                      })),
                  CustomText(
                    text: 'receivedWrongProduct'.tr,
                  )
                ],
              );
            }),
            Obx(() {
              return Row(
                children: [
                  Radio(
                      value: 2,
                      groupValue: _returnController.returnReason.value,
                      onChanged: ((newValue) {
_returnController.returnReason.value = newValue!;
                        print(_returnController.returnReason.value);                        _returnController.isReasonSelected.value = true;
                      })),
                  CustomText(
                    text: 'productArrivedDamaged'.tr,
                  )
                ],
              );
            }),
            Obx(() {
              return Row(
                children: [
                  Radio(
                      value: 5,
                      groupValue: _returnController.returnReason.value,
                      onChanged: ((newValue) {
                        _returnController.returnReason.value = newValue!;
                        _returnController.isReasonSelected.value = true;
                      })),
                  CustomText(
                    text: 'otherReasons'.tr,
                  )
                ],
              );
            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Obx(
                    () => _returnController.returnReason.value == 5
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  CustomText(
                                    text: 'selectReasonForReturn'.tr,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const CustomText(
                                    text: '*',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: vermillion,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomTextField(
                                controller: _ReasonController,
                                maxLines: 4,
                                hintText: 'typeReason'.tr,
                              ),
                            ],
                          )
                        : Container(),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      CustomText(
                        text: 'isOpen'.tr,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const CustomText(
                        text: '*',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: vermillion,
                      ),
                      Obx(() {
                        return Radio(
                            value: 1,
                            groupValue: _returnController.isOpened.value,
                            onChanged: ((newValue) {
                           
                              _returnController.isOpened.value = newValue!;
                              _returnController.isOpenSelected.value = true;

              
                            }));
                      }),
                      CustomText(
                        text: 'yes'.tr,
                      ),
                      Obx(() {
                        return Radio(
                            value: 0,
                            groupValue: _returnController.isOpened.value,
                            onChanged: ((newValue) {
                              // setState(() {
                              _returnController.isOpened.value = newValue!;
                              print(  _returnController.isOpened.value);
                              _returnController.isOpenSelected.value = true;
                              // });
                            }));
                      }),
                      CustomText(
                        text: 'no'.tr,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            const Divider(
              color: darkGrey,
              thickness: 10,
            ),
            Obx(() {
                if (_returnController.isSendLoading.value) {
                      return const Column(
                        children: [
                          CircularProgressIndicator(),
                        ],
                      );
                    }
              return  Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomButton(
                  onPressed: () async {
              
                    if (_returnController.isReasonSelected.value &
                          _returnController.isOpenSelected.value &
                        selectedProduct!.isNotEmpty)
                    {
                    returnId = await widget.returnController.makeReturn(
                        widget.returnController.returnOrder!.orderId,
                        widget.returnController.returnOrder!.dateOrdered,
                        widget.returnController.returnOrder!.firstName!,
                        widget.returnController.returnOrder!.lastName!,
                        widget.returnController.returnOrder!.email!,
                        widget.returnController.returnOrder!.phone!,
                       _returnController.returnReason.value,
                        
                        _returnController.isOpened.value,
                        selectedProduct!
                        ,
                        context);
              
                       if (returnId != null) {
                         Get.offAll(() => ThankYouScreen(orderId: returnId!, email: widget.returnController.returnOrder!.email!,isReturn: true,)) ;
                       }
                    } 
                  },
                  color: _returnController.isReasonSelected.value &
                          _returnController.isOpenSelected.value &
                        selectedProduct!.isNotEmpty
                      ? Colors.black
                      : darkGrey,
                  title: "send".tr,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
