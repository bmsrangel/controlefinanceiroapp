import 'package:controlefinanceiroapp/app/app_bloc.dart';
import 'package:controlefinanceiroapp/app/app_module.dart';
import 'package:controlefinanceiroapp/app/modules/auth/auth_module.dart';
import 'package:flutter/material.dart';
import 'package:controlefinanceiroapp/app/modules/home/home_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppBloc bloc = AppModule.to.bloc<AppBloc>();
    return MaterialApp(
      title: 'Flutter Slidy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: bloc.outIsLogged,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snapshot.data) return HomeModule();
          return AuthModule();
        },
      ),
    );
  }
}
