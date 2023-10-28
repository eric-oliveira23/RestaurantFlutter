// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  String item;
  int quantidade;
  double valor;
  String hash;
  String? imagem;

  ProductModel({
    required this.item,
    required this.quantidade,
    required this.valor,
    required this.hash,
    this.imagem,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        item: json["item"],
        quantidade: json["quantidade"],
        valor: json["valor"]?.toDouble(),
        hash: json["hash"],
        imagem: json["imagem"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "item": item,
        "quantidade": quantidade,
        "valor": valor,
        "hash": hash,
        "imagem": imagem,
      };
}
