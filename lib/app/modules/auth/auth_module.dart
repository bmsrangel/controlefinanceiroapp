import 'package:controlefinanceiroapp/app/app_module.dart';
import 'package:controlefinanceiroapp/app/modules/auth/auth_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:controlefinanceiroapp/app/shared/repositories/auth_repository.dart';
import 'package:controlefinanceiroapp/app/shared/services/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:controlefinanceiroapp/app/modules/auth/auth_page.dart';

class AuthModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc(
          (i) => AuthBloc(
            i.getDependency<AuthRepository>(),
            i.getDependency<SecureStorageService>(),
          ),
        ),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => AppModule.to.get<AuthRepository>()),
        Dependency((i) => AppModule.to.get<SecureStorageService>()),
      ];

  @override
  Widget get view => AuthPage();

  static Inject get to => Inject<AuthModule>.of();
}
