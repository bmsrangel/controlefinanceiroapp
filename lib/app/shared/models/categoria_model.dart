class CategoriaModel {
  int id;
  String categoria;

  CategoriaModel({
    this.id,
    this.categoria,
  });

  factory CategoriaModel.fromJson(Map<String, dynamic> json) => CategoriaModel(
        id: json["id"],
        categoria: json["categoria"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoria": categoria,
      };
}
