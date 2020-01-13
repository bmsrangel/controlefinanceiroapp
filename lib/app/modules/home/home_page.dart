import 'package:controlefinanceiroapp/app/app_module.dart';
import 'package:controlefinanceiroapp/app/modules/home/components/movimentations/movimentations_widget.dart';
import 'package:controlefinanceiroapp/app/modules/home/components/selector/selector_widget.dart';
import 'package:controlefinanceiroapp/app/modules/home/home_bloc.dart';
import 'package:controlefinanceiroapp/app/modules/home/home_module.dart';
import 'package:controlefinanceiroapp/app/shared/services/secure_storage_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Movimentações"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SecureStorageService storage = AppModule.to.get<SecureStorageService>();
  HomeBloc bloc = HomeModule.to.bloc<HomeBloc>();

  PageController _page$ = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              storage.clearAll();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SelectorWidget(
            pageController: _page$,
          ),
          MovimentationsWidget(
            pageController: _page$,
          ),
        ],
      ),
    );
  }
}
