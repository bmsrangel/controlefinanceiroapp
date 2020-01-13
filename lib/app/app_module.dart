import 'package:controlefinanceiroapp/app/shared/services/secure_storage_service.dart';
import 'package:controlefinanceiroapp/app/shared/repositories/hasura_repository.dart';
import 'package:controlefinanceiroapp/app/shared/repositories/auth_repository.dart';
import 'package:controlefinanceiroapp/app/app_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:controlefinanceiroapp/app/app_widget.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => AppBloc(i.get<SecureStorageService>())),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => SecureStorageService()),
        Dependency((i) => HasuraRepository(i.get<SecureStorageService>()),
            singleton: true),
        Dependency((i) => AuthRepository()),
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
