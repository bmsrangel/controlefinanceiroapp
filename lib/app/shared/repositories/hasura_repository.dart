import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:controlefinanceiroapp/app/shared/models/categoria_model.dart';
import 'package:controlefinanceiroapp/app/shared/models/mes_model.dart';
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

  Future<List<MesModel>> getAllMesesComRegistros() async {
    String query = """
      query allMeses {
        meses(order_by: {ano: desc, num_mes: desc}) {
          id
          mes
          ano
          num_mes
        }
      }
    """;

    try {
      var data = await _connection.query(query);
      return data["data"]["meses"]
          .map<MesModel>((mes) => MesModel.fromJson(mes))
          .toList();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addMes() async {
    String query = """
      mutation addMes {
        insert_meses(objects: {mes: "Fevereiro", ano: 2020, num_mes: 2, uid: "kluXHFHX3IUlhb4PPyHpINcptQE2"}) {
          affected_rows
        }
      }

    """;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
