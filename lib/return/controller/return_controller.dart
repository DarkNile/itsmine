import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:itsmine/product/models/product.dart';
import 'package:itsmine/return/services/return_service.dart';

import '../model/return.dart';

class ReturnController extends GetxController {
  var isCheckReturnOrderIdLoading = false.obs;
  var isOTPLoading = false.obs;
  var isSendLoading = false.obs;


  var isSendOTP = false.obs;
  var isCorrectOTP = false.obs;
  var returnReason = 9.obs;
  var isOpened = 3.obs;
  var isReasonSelected = false.obs;
  var isOpenSelected = false.obs;


  Return? returnOrder;

  Future<bool> checkReturnOrderId(String orderId,bool resend, BuildContext context) async {
    try {
    if (!resend)  isCheckReturnOrderIdLoading(true);
      final data = await ReturnService.checkReturnOrderId(orderId, context);
      isSendOTP(data);
      return isSendOTP.value;
    } catch (e) {
      print(e);
      return false;
    } finally {
         if (!resend) isCheckReturnOrderIdLoading(false);
    }
  }

  Future<Return?> checkOTP(
      String orderId, String OTP, BuildContext context) async {
    try {
      isOTPLoading(true);
      final data =
          await ReturnService.checkActivationCode(orderId, OTP, context);

      if (data != null) {
        isCorrectOTP(true);
        returnOrder = data;
        return returnOrder;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isOTPLoading(false);
    }
  }

  Future<int?> makeReturn(
      String orderId,
      String dateOrdered,
      String firstName,
      String lastName,
      String email,
      String phone,
      int returnReason,
      int opened,
      List<Product> products,
      BuildContext context) async {
    try {
        isSendLoading(true);
      final data = await ReturnService.makeReturn(
          orderId,
          dateOrdered,
          firstName,
          lastName,
          email,
          phone,
          returnReason,
          opened,
          products,
          context);
      // isCorrectOTP(true);
      if (data != null) {
        //  returnOrder = data;
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    } finally {
      isSendLoading(false);
    }
  }
}
