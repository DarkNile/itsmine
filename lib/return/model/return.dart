import 'package:itsmine/product/models/product.dart';

class Return {
  dynamic orderId;
  dynamic dateOrdered,returnReason,opened;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? image;
  List<Product>? products;

  Return({
    this.orderId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.image,
    this.products,
  });

  Return.fromJson(Map<String, dynamic> json) {

    orderId = json['customer']['order_id'];
    dateOrdered = json['customer']['date_ordered'];
    firstName = json['customer']['firstname'];
    lastName = json['customer']['lastname'];
    email = json['customer']['email'];
    phone = json['customer']['telephone'];
    products = json["products"] == null
        ? null
        : (json["products"] as List).map((e) => Product.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer']['order_id'] = orderId;
    data['customer']['date_ordered'] = dateOrdered;
    data['customer']['firstname'] = firstName;
    data['customer']['lastname'] = lastName;
    data['customer']['email'] = email;
    data['customer']['telephone'] = phone;
    if (products != null) {
      data["products"] = products?.map((e) => e.toJson()).toList();
   }
    return data;
  }
}
