import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:controlefinanceiroapp/app/shared/models/categoria_model.dart';
import 'package:controlefinanceiroapp/app/shared/models/registro_model.dart';
import 'package:controlefinanceiroapp/app/shared/services/secure_storage_service.dart';
import 'package:hasura_connect/hasura_connect.dart';

class HasuraRepository extends Disposable {
  final SecureStorageService _secureStorage;
  HasuraConnect _connection;
  String uid;
  HasuraRepository(this._secureStorage) {
    _init();
  }

  void _init() async {
    uid = await _secureStorage.getUid();
    _connection = HasuraConnect(
      "https://controlefinanceiroapp.herokuapp.com/v1/graphql",
      // "http://10.0.2.2:8080/v1/graphql",
      token: (isError) async {
        String token = await _secureStorage.getToken();
        if (token != null) return "Bearer $token";
        return null;
      },
    );
  }

  Future<List<CategoriaModel>> getAllCategorias() async {
    String query = """
      query allCategorias {
        categorias(order_by: {categoria: asc}) {
          id
          categoria
        }
      }
    """;

    try {
      var data = await _connection.query(query);
      return data["data"]["categorias"]
          .map<CategoriaModel>(
              (categoria) => CategoriaModel.fromJson(categoria))
          .toList();
    } catch (e) {
      throw e;
    }
  }

  Future<List<RegistroModel>> getLastRegistros({int limite}) async {
    String query = """
      query getLastRegistros(\$limite:Int!) {
        registros(limit: \$limite, order_by: {data: desc}) {
          id
          descricao
          data
          valor
          categoria {
            id
            categoria
          }
        }
      }
    """;
    var data = await _connection.query(query, variables: {
      "limite": limite,
    });
    print(data);
    return data["data"]["registros"]
        .map<RegistroModel>((registro) => RegistroModel.fromJson(registro))
        .toList();
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
