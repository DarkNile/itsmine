import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:itsmine/constants/urls.dart';
import 'package:itsmine/home/models/category.dart';
import 'package:itsmine/home/models/location.dart';
import 'package:itsmine/product/models/product.dart';

import 'package:itsmine/utils/app_util.dart';

import '../model/return.dart';

class ReturnService {

  static Future<bool>  checkReturnOrderId(String orderId,BuildContext context) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.post(
      Uri.parse('$baseUrl route=rest/return/check_order_id&language=$lang'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=8d87b6a83c38ea74f58b36afc3; currency=SAR;",
      },

      body: jsonEncode({
        "order_id": orderId,
    
      }),
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      print('data: $data');
      return true;
    } else {
      if (context.mounted)
    {  AppUtil.errorToast(context, jsonDecode(response.body)['error'][0]);}
      return false;
    }
  }

  static Future<Return?>  checkActivationCode(String orderId,String otp,BuildContext context) async {
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);
    final response = await http.post(
      Uri.parse('$baseUrl route=rest/return/check_activation_code&language=$lang'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=8d87b6a83c38ea74f58b36afc3; currency=SAR;",
      },

      body: jsonEncode({
        "order_id": orderId,
        "return_activation_code":otp,
    
      }),
    );
    print('response status code: ${response.statusCode}');
    print(jsonDecode(response.body)['success']);
    if (jsonDecode(response.body)['success'] == 1) {
  
       Map<String,dynamic> data = jsonDecode(response.body)['data'];
       print("Data: $data" );
      
       var theRe =  Return.fromJson(data); 
       print( "EMAIL ${theRe.email}");
      return Return.fromJson(data);
    } else {
      if (context.mounted)
    {  AppUtil.errorToast(context, jsonDecode(response.body)['error'][0]);}
      return null;
    }
  }


  static Future<int?>  makeReturn(
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
    final getStorage = GetStorage();
    final String? token = getStorage.read('token');
    print(token);
    final String? lang = getStorage.read('lang');
    print(lang);

        List<Map<String, dynamic>> listProducts = <Map<String, dynamic>>[];
            for (var product in products) {
      Map<String, dynamic> val = {
        'product_id': product.productId,
        'name': product.name,
        'model': product.model.toString(),
        'price': product.price.toString(),
        'quantity': product.quantity.toString(),
        'option': product.option,
        'total': product.price ,
      };
      listProducts.add(val);
    }

    final response = await http.post(
      Uri.parse('$baseUrl route=rest/return/returns&language=$lang'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        "Cookie": "OCSESSID=8d87b6a83c38ea74f58b36afc3; currency=SAR;",
      },

      

      body: jsonEncode({
        "customer": {
          "order_id":orderId,
          "date_ordered":dateOrdered,
          "firstname":firstName,
          "lastname":lastName,
          "email":email,
          "telephone":phone,
          "return_reason_id":returnReason,
          "opened":opened,
        },
        "products": products
    
      }),
    );
    print('response status code: ${response.statusCode}');
    if (jsonDecode(response.body)['success'] == 1) {
      int data = jsonDecode(response.body)['data']['id'];
      print('data: $data');
      return data;
    } else {
      if (context.mounted)
    {  AppUtil.errorToast(context, jsonDecode(response.body)['error'][0]);}
      return null;
    }
  }
}
