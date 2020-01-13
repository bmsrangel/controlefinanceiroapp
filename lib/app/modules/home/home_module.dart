import 'package:controlefinanceiroapp/app/app_module.dart';
import 'package:controlefinanceiroapp/app/modules/home/home_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:controlefinanceiroapp/app/shared/repositories/hasura_repository.dart';
import 'package:flutter/material.dart';
import 'package:controlefinanceiroapp/app/modules/home/home_page.dart';

class HomeModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => HomeBloc(AppModule.to.get<HasuraRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => HomePage();

  static Inject get to => Inject<HomeModule>.of();
}
