import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:controlefinanceiroapp/app/shared/models/categoria_model.dart';
import 'package:controlefinanceiroapp/app/shared/models/registro_model.dart';
import 'package:controlefinanceiroapp/app/shared/repositories/hasura_repository.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  final HasuraRepository repo;

  HomeBloc(this.repo) {
    Future.delayed(Duration(milliseconds: 500), () {
      getLastRegistros();
    });
  }

  BehaviorSubject<List<CategoriaModel>> categorias$ =
      BehaviorSubject<List<CategoriaModel>>.seeded([]);
  Sink<List<CategoriaModel>> get inCategorias => categorias$.sink;
  Stream<List<CategoriaModel>> get outCategorias => categorias$.stream;

  BehaviorSubject<CategoriaModel> categoriaSelecionada$ =
      BehaviorSubject<CategoriaModel>();
  Sink<CategoriaModel> get inSelecionada => categoriaSelecionada$.sink;
  Stream<CategoriaModel> get outSelecionada => categoriaSelecionada$.stream;

  BehaviorSubject<List<RegistroModel>> registros$ =
      BehaviorSubject<List<RegistroModel>>();
  Sink<List<RegistroModel>> get inRegistros => registros$.sink;
  Stream<List<RegistroModel>> get outRegistros => registros$.stream;

  List<RegistroModel> pages;

  Future<void> getAllCategories() async {
    List<CategoriaModel> categorias = await repo.getAllCategorias();
    if (categorias.length > 0) {
      inSelecionada.add(categorias[0]);
    }
    inCategorias.add(categorias);
  }

  Future<void> getLastRegistros({int limite}) async {
    try {
      pages = await repo.getLastRegistros(limite: limite ?? 10);
      inRegistros.add(pages);
    } on HasuraError catch (e) {
      if (e.message == "connection error")
        registros$.addError("Erro de conexão com o banco de dados");
      else
        registros$.addError(e.message);
    }
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    categorias$.close();
    categoriaSelecionada$.close();
    registros$.close();
    super.dispose();
  }
}
