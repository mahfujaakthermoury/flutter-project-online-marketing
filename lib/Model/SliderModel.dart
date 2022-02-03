// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

List<SliderModel> sliderModelFromJson(String str) => List<SliderModel>.from(json.decode(str).map((x) => SliderModel.fromJson(x)));

String sliderModelToJson(List<SliderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SliderModel {
  SliderModel({
    this.id,
    this.sliderImage,
    this.status,
  });

  int id;
  String sliderImage;
  String status;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    id: json["id"],
    sliderImage: json["slider_image"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slider_image": sliderImage,
    "status": status,
  };
}
