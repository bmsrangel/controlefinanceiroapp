import 'dart:convert';

import 'package:controlefinanceiroapp/app/shared/models/categoria_model.dart';

RegistroModel registroModelFromJson(String str) =>
    RegistroModel.fromJson(json.decode(str));

String registroModelToJson(RegistroModel data) => json.encode(data.toJson());

class RegistroModel {
  int id;
  String descricao;
  DateTime data;
  double valor;
  CategoriaModel categoria;

  RegistroModel({
    this.id,
    this.descricao,
    this.data,
    this.valor,
    this.categoria,
  });

  factory RegistroModel.fromJson(Map<String, dynamic> json) => RegistroModel(
        id: json["id"],
        descricao: json["descricao"],
        data: DateTime.parse(json["data"]),
        valor: json["valor"].toDouble(),
        categoria: CategoriaModel.fromJson(json["categoria"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": descricao,
        "data":
            "${data.year.toString().padLeft(4, '0')}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}",
        "valor": valor,
        "categoria": categoria.toJson(),
      };
}
