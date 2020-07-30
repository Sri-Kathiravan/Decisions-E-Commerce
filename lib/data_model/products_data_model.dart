import 'dart:convert';

List<ProductsDm> productsDmFromJson(String str) => List<ProductsDm>.from(json.decode(str).map((x) => ProductsDm.fromJson(x)));

String productsDmToJson(List<ProductsDm> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsDm {
  ProductsDm({
    this.name,
    this.definitionUrl,
  });

  String name;
  String definitionUrl;

  factory ProductsDm.fromJson(Map<String, dynamic> json) => ProductsDm(
    name: json["name"],
    definitionUrl: json["definitionUrl"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "definitionUrl": definitionUrl,
  };
}