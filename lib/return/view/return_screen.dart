import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:itsmine/constants/colors.dart';
import 'package:itsmine/return/model/return.dart';
import 'package:itsmine/return/view/order_info.dart';
import 'package:itsmine/utils/app_util.dart';
import 'package:itsmine/widgets/custom_header.dart';
import 'package:get/get.dart';
import 'package:itsmine/widgets/custom_text.dart';
import 'package:itsmine/widgets/custom_text_field.dart';

import '../../widgets/custom_body_title.dart';
import '../../widgets/custom_button.dart';

import '../controller/return_controller.dart';
import 'dart:async';

class ReturnScreen extends StatefulWidget {
  const ReturnScreen({super.key});

  @override
  State<ReturnScreen> createState() => _ReturnScreenState();
}

class _ReturnScreenState extends State<ReturnScreen> {
  final _maxSeconds = 60;
  int _currentSecond = 0;
   Timer? _timer ;
  String get _timerText {
    final secondsPerMinute = 60;
    final secondsLeft = _maxSeconds - _currentSecond;

    final formattedMinutesLeft =
        (secondsLeft ~/ secondsPerMinute).toString().padLeft(2, '0');
    final formattedSecondsLeft =
        (secondsLeft % secondsPerMinute).toString().padLeft(2, '0');

    print('$formattedMinutesLeft : $formattedSecondsLeft');
    return AppUtil.rtlDirection(context)
        ? '$formattedSecondsLeft : $formattedMinutesLeft '
        : '$formattedMinutesLeft : $formattedSecondsLeft';
  }

  final _orderNumController = TextEditingController();
  final _OTPController = TextEditingController();

  Return? returnOrder;

  final _returnController = Get.put(ReturnController());

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   if (_timer != null ){
     _timer!.cancel();
   }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomHeader(title: 'returnProduct'.tr),
        body: Column(
          children: [
            CustomBodyTitle(title: 'returnProduct'.tr),
            Padding(
              padding: EdgeInsets.only(top: 53, right: 19, left: 19, bottom: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'enterOrderId'.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  CustomText(
                    text: 'willSendCode'.tr,
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                    color: brownishGrey,
                  ),
                  const SizedBox(
                    height: 41,
                  ),
                  const Divider(
                    color: darkGrey,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 41,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: 'orderNumber'.tr,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const CustomText(
                        text: '*',
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: vermillion,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  CustomTextField(
                      controller: _orderNumController, hintText: "00000"),
                  const SizedBox(
                    height: 26,
                  ),
                  Obx(() {
                    if (_returnController.isCheckReturnOrderIdLoading.value) {
                      return CircularProgressIndicator();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(left: 201),
                      child: CustomButton(
                        onPressed: () async {
                          //  await _returnController.checkReturnOrderId(
                          //       _orderNumController.text,false, context);
                          late var result;
                          if(_timer == null ){
                            _startTimer();
                            result = await _returnController.checkReturnOrderId(
                                _orderNumController.text,false, context);
                            
                          } else {
                            _timer!.cancel();
                           if (!_timer!.isActive ) {
                            result = await _returnController.checkReturnOrderId(
                                _orderNumController.text,false, context);
                            if (result) _startTimer();
                          }
                          }
                          
                        },
                        title: 'sendCode'.tr,
                        fontSize: 12,
                      ),
                    );
                  }),
                  Obx(() {
                    if (_returnController.isSendOTP.value) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          Row(
                            children: [
                              CustomText(
                                text: 'enterCode'.tr,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const CustomText(
                                text: '*',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: vermillion,
                              ),
                              const Spacer(),
                              CustomText(
                                  text:
                                      "${"remains".tr} $_timerText ${"sec".tr}",
                                  color: orange)
                            ],
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          CustomTextField(
                            controller: _OTPController,
                            suffixIcon: _returnController.isCorrectOTP.value
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        'assets/icons/done.svg'),
                                  )
                                : Container(
                                    width: 0,
                                  ),
                            hintText: 'code'.tr,
                          ),
                          _returnController.isSendOTP.value
                              ? const SizedBox(
                                  height: 26,
                                )
                              : Container(),
                          _returnController.isCorrectOTP.value
                              ? CustomButton(
                                  onPressed: () {},
                                  title: 'confirmed'.tr,
                                  color: jadeGreen,
                                )
                              : Obx(() {
                                  if (_returnController.isOTPLoading.value) {
                                    return CircularProgressIndicator();
                                  }
                                  return Row(
                                    children: [
                                      Container(
                                        width: 142,
                                        child: CustomButton(
                                          onPressed: () async {
                                            var data = await _returnController
                                                .checkOTP(
                                                    _orderNumController.text,
                                                    _OTPController.text,
                                                    context);
                                          },
                                          title: 'confirmOTP'.tr,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Spacer(),
                                      SvgPicture.asset(
                                        'assets/icons/resend.svg',
                                        color: _timer!.isActive
                                            ? brownishGrey.withOpacity(0.2)
                                            : Colors.black,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          late var result;
                                          if (!_timer!.isActive) {
                                            result = await _returnController
                                                .checkReturnOrderId(
                                                    _orderNumController.text,
                                                    true,
                                                    context);
                                            if (result) _startTimer();
                                          }
                                        },
                                        child: CustomText(
                                          text: 'resendCode'.tr,
                                          textDecoration:
                                              TextDecoration.underline,
                                          color: _timer!.isActive
                                              ? brownishGrey.withOpacity(0.3)
                                              : Colors.black,
                                        ),
                                      )
                                    ],
                                  );
                                }),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Obx(() {
                return CustomButton(
                  onPressed: () {
                    print(returnOrder);

                    if (_returnController.isCorrectOTP.value)
                      Get.off(() =>
                          OrderInfoScreen(returnController: _returnController));
                  },
                  color: !_returnController.isCorrectOTP.value
                      ? darkGrey
                      : darkBlack,
                  title: "next".tr,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _startTimer() {
    print("Started");
    final duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, (Timer timer) {
      setState(() {
        _currentSecond = timer.tick;
        if (timer.tick >= _maxSeconds) timer.cancel();
      });
    });
  }
}
