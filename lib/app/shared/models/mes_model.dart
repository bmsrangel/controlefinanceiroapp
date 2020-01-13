class MesModel {
  final int id;
  final String mes;
  final int ano;
  final int numMes;

  MesModel({this.id, this.mes, this.ano, this.numMes});

  factory MesModel.fromJson(Map json) => MesModel(
        id: json["id"],
        mes: json["mes"],
        ano: json["ano"],
        numMes: json["num_mes"],
      );

  Map toJson() => {
        "id": id,
        "mes": mes,
        "ano": ano,
        "num_mes": numMes,
      };
}
