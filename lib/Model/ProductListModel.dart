// To parse this JSON data, do
//
//     final modelProductList = modelProductListFromJson(jsonString);

import 'dart:convert';

List<ModelProductList> modelProductListFromJson(String str) => List<ModelProductList>.from(json.decode(str).map((x) => ModelProductList.fromJson(x)));

String modelProductListToJson(List<ModelProductList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelProductList {
  ModelProductList({
    this.id,
    this.categoryId,
    this.name,
    this.img1,
    this.img2,
    this.img3,
    this.img4,
    this.img5,
    this.price,
    this.selling,
    this.description,
  });

  int id;
  String categoryId;
  String name;
  String img1;
  dynamic img2;
  dynamic img3;
  dynamic img4;
  dynamic img5;
  String price;
  String selling;
  String description;

  factory ModelProductList.fromJson(Map<String, dynamic> json) => ModelProductList(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
    img1: json["img1"],
    img2: json["img2"],
    img3: json["img3"],
    img4: json["img4"],
    img5: json["img5"],
    price: json["price"],
    selling:json["selling_price"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "img1": img1,
    "img2": img2,
    "img3": img3,
    "img4": img4,
    "img5": img5,
    "price": price,
    "selling_price":selling,
    "description": description,
  };
}
