import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:controlefinanceiroapp/app/modules/auth/auth_bloc.dart';
import 'package:controlefinanceiroapp/app/modules/auth/auth_module.dart';

void main() {
  initModule(AuthModule());
  AuthBloc bloc;

  setUp(() {
    bloc = AuthModule.to.bloc<AuthBloc>();
  });

  group('AuthBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<AuthBloc>());
    });
  });
}
