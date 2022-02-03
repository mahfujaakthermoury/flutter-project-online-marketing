// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

List<ModelOrder> orderModelFromJson(String str) => List<ModelOrder>.from(json.decode(str).map((x) => ModelOrder.fromJson(x)));

String orderModelToJson(List<ModelOrder> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelOrder {
  ModelOrder({
    this.id,
    this.userId,
    this.totalPrice,
    this.status,
    this.createAt,
    this.details,
    this.user,
    this.shipping,
  });

  int id;
  String userId;
  String totalPrice;
  String status;
  DateTime createAt;
  List<Detail> details;
  User user;
  Shipping shipping;

  factory ModelOrder.fromJson(Map<String, dynamic> json) => ModelOrder(
    id: json["id"],
    userId: json["user_id"],
    totalPrice: json["total_price"],
    status:json["status"],
    createAt: DateTime.parse(json["create_at"]),
    details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    user: json["user"] == null ? [] : User.fromJson(json["user"]),
    shipping: json["shipping"] == null ? '' : Shipping.fromJson(json["shipping"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "total_price": totalPrice,
    "status": status,
    "create_at": createAt.toIso8601String(),
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
    "user": user == null ? null : user.toJson(),
    "shipping": shipping == null ? null : shipping.toJson(),
  };
}

class Detail {
  Detail({
    this.id,
    this.orderId,
    this.productId,
    this.productName,
    this.price,
    this.quantity,
  });

  int id;
  String orderId;
  String productId;
  String productName;
  String price;
  String quantity;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    productName: json["product_name"],
    price: json["price"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "product_name": productName,
    "price": price,
    "quantity": quantity,
  };
}


class Shipping {
  Shipping({
    this.id,
    this.orderId,
    this.shippingAddress,
  });

  int id;
  String orderId;
  String shippingAddress;

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
    id: json["id"],
    orderId: json["order_id"],
    shippingAddress:json["shipping_address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "shipping_address":shippingAddress,
  };
}


class User {
  User({
    this.id,
    this.name,
    this.phone,
    this.password,
    this.profileimage,
    this.email,
    this.isActive,
    this.isVerifide,
    this.address,
  });

  int id;
  String name;
  String phone;
  String password;
  String profileimage;
  String email;
  int isActive;
  int isVerifide;
  String address;


  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name:json["name"],
    phone: json["phone"],
    password:json["password"],
    profileimage: json["profileimage"],
    email: json["email"],
    isActive: json["is_active"],
    isVerifide: json["is_Verifide"],
    address: json["address"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name":name,
    "phone": phone,
    "password": password,
    "profileimage": profileimage,
    "email": email,
    "is_active": isActive,
    "is_Verifide": isVerifide,
    "address": address,

  };
}






