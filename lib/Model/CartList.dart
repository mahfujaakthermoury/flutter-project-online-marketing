// To parse this JSON data, do
//
//     final modelCatList = modelCatListFromJson(jsonString);

import 'dart:convert';

List<ModelCatList> modelCartListFromJson(String str) => List<ModelCatList>.from(json.decode(str).map((x) => ModelCatList.fromJson(x)));

String modelCartListToJson(List<ModelCatList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelCatList {
  ModelCatList({
    this.id,
    this.name,
    this.categoryImage,
    this.isActive,
  });

  int id;
  String name;
  String categoryImage;
  int isActive;

  factory ModelCatList.fromJson(Map<String, dynamic> json) => ModelCatList(
    id: json["id"],
    name: json["name"],
    categoryImage: json["category_image"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category_image": categoryImage,
    "is_active": isActive,
  };
}
