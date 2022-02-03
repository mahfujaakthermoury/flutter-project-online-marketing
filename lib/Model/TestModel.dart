// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

List<CategoriesModel> categoriesModelFromJson(String str) => List<CategoriesModel>.from(json.decode(str).map((x) => CategoriesModel.fromJson(x)));

String categoriesModelToJson(List<CategoriesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriesModel {
  CategoriesModel({
    this.id,
    this.parentId,
    this.name,
    this.nameBn,
    this.icon,
    this.thumbnail,
    this.orderBy,
    this.imagelink,
    this.subcategory,
    this.attachment,
  });

  int id;
  String parentId;
  String name;
  String nameBn;
  dynamic icon;
  String thumbnail;
  String orderBy;
  String imagelink;
  List<CategoriesModel> subcategory;
  Attachment attachment;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    id: json["id"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    name: json["name"],
    nameBn: json["name_bn"],
    icon: json["icon"],
    thumbnail: json["thumbnail"],
    orderBy: json["order_by"],
    imagelink: json["imagelink"] == null ? null : json["imagelink"],
    subcategory: json["subcategory"] == null ? null : List<CategoriesModel>.from(json["subcategory"].map((x) => CategoriesModel.fromJson(x))),
    attachment: json["attachment"] == null ? null : Attachment.fromJson(json["attachment"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId == null ? null : parentId,
    "name": name,
    "name_bn": nameBn,
    "icon": icon,
    "thumbnail": thumbnail,
    "order_by": orderBy,
    "imagelink": imagelink == null ? null : imagelink,
    "subcategory": subcategory == null ? null : List<dynamic>.from(subcategory.map((x) => x.toJson())),
    "attachment": attachment == null ? null : attachment.toJson(),
  };
}

class Attachment {
  Attachment({
    this.id,
    this.attachmenDirectory,
    this.attachmentName,
    this.attachmentFormat,
    this.attachmentCaption,
    this.attachmentTitle,
    this.userId,
  });

  int id;
  AttachmenDirectory attachmenDirectory;
  String attachmentName;
  AttachmentFormat attachmentFormat;
  String attachmentCaption;
  String attachmentTitle;
  dynamic userId;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    id: json["id"],
    attachmenDirectory: attachmenDirectoryValues.map[json["attachmen_directory"]],
    attachmentName: json["attachment_name"],
    attachmentFormat: attachmentFormatValues.map[json["attachment_format"]],
    attachmentCaption: json["attachment_caption"],
    attachmentTitle: json["attachment_title"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attachmen_directory": attachmenDirectoryValues.reverse[attachmenDirectory],
    "attachment_name": attachmentName,
    "attachment_format": attachmentFormatValues.reverse[attachmentFormat],
    "attachment_caption": attachmentCaption,
    "attachment_title": attachmentTitle,
    "user_id": userId,
  };
}

enum AttachmenDirectory { THE_202010, THE_202101, THE_202103 }

final attachmenDirectoryValues = EnumValues({
  "2020/10": AttachmenDirectory.THE_202010,
  "2021/01": AttachmenDirectory.THE_202101,
  "2021/03": AttachmenDirectory.THE_202103
});

enum AttachmentFormat { JPG, PNG }

final attachmentFormatValues = EnumValues({
  ".jpg": AttachmentFormat.JPG,
  ".png": AttachmentFormat.PNG
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
