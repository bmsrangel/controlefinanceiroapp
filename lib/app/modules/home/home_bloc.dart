import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:controlefinanceiroapp/app/shared/models/categoria_model.dart';
import 'package:controlefinanceiroapp/app/shared/models/mes_model.dart';
import 'package:controlefinanceiroapp/app/shared/repositories/hasura_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  final HasuraRepository repo;

  HomeBloc(this.repo) {
    Future.delayed(Duration(milliseconds: 400), () {
      getAllMeses();
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

  BehaviorSubject<MesModel> pagSelec$ = BehaviorSubject<MesModel>();
  Sink<MesModel> get inPageSel => pagSelec$.sink;
  Stream<MesModel> get outPageSel => pagSelec$.stream;

  BehaviorSubject<List<MesModel>> meses$ = BehaviorSubject<List<MesModel>>();
  Sink<List<MesModel>> get inMeses => meses$.sink;
  Stream<List<MesModel>> get outMeses => meses$.stream;
  List<MesModel> pages;

  Future<void> getAllCategories() async {
    List<CategoriaModel> categorias = await repo.getAllCategorias();
    if (categorias.length > 0) {
      inSelecionada.add(categorias[0]);
    }
    inCategorias.add(categorias);
  }

  Future<void> getAllMeses() async {
    pages = await repo.getAllMesesComRegistros();
    inMeses.add(pages);
    inPageSel.add(pages[0]);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    categorias$.close();
    categoriaSelecionada$.close();
    pagSelec$.close();
    meses$.close();
    super.dispose();
  }
}
