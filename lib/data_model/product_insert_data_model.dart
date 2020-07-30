import 'dart:convert';

List<ProductInsertDm> productInsertDmFromJson(String str) => List<ProductInsertDm>.from(json.decode(str).map((x) => ProductInsertDm.fromJson(x)));

String productInsertDmToJson(List<ProductInsertDm> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductInsertDm {
  ProductInsertDm({
    this.caption,
    this.type,
    this.mandatory,
    this.defaultValue,
    this.validationMessage,
  });

  String caption;
  String type;
  bool mandatory;
  String defaultValue;
  String validationMessage;

  factory ProductInsertDm.fromJson(Map<String, dynamic> json) => ProductInsertDm(
    caption: json["caption"],
    type: json["type"],
    mandatory: json["mandatory"],
    defaultValue: json["defaultValue"],
    validationMessage: json["validationMessage"],
  );

  Map<String, dynamic> toJson() => {
    "caption": caption,
    "type": type,
    "mandatory": mandatory,
    "defaultValue": defaultValue,
    "validationMessage": validationMessage,
  };
}