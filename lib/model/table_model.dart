// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final tableModel = tableModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

List<TableModel> tableModelFromJson(String str) =>
    List<TableModel>.from(json.decode(str).map((x) => TableModel.fromJson(x)));

String tableModelToJson(List<TableModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TableModel {
  int numero;
  List<Pedido> pedidos;
  String? nome;
  double total;

  TableModel({
    required this.numero,
    required this.pedidos,
    required this.total,
    this.nome,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        numero: json["numero"],
        nome: json["nome"] ?? '',
        total: double.parse(json["total"].toString()),
        pedidos: List<Pedido>.from(
          json["pedidos"].map(
            (x) => Pedido.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "numero": numero,
        "nome": nome,
        "total": total,
        "pedidos": List<dynamic>.from(
          pedidos.map(
            (x) => x.toJson(),
          ),
        ),
      };

  TableModel copyWith({
    int? numero,
    List<Pedido>? pedidos,
    String? nome,
    double? total,
  }) {
    return TableModel(
      numero: numero ?? this.numero,
      pedidos: pedidos ?? this.pedidos,
      nome: nome ?? this.nome,
      total: total ?? this.total,
    );
  }

  @override
  bool operator ==(covariant TableModel other) {
    if (identical(this, other)) return true;

    return other.numero == numero &&
        listEquals(other.pedidos, pedidos) &&
        other.nome == nome &&
        other.total == total;
  }

  @override
  int get hashCode {
    return numero.hashCode ^ pedidos.hashCode ^ nome.hashCode ^ total.hashCode;
  }
}

class Pedido {
  String item;
  int quantidade;

  Pedido({
    required this.item,
    required this.quantidade,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
        item: json["item"],
        quantidade: json["quantidade"],
      );

  Map<String, dynamic> toJson() => {
        "item": item,
        "quantidade": quantidade,
      };
}
