import 'package:controlefinanceiroapp/app/modules/home/home_bloc.dart';
import 'package:controlefinanceiroapp/app/modules/home/home_module.dart';
import 'package:controlefinanceiroapp/app/shared/models/mes_model.dart';
import 'package:flutter/material.dart';

class SelectorWidget extends StatelessWidget {
  final PageController pageController;

  const SelectorWidget({Key key, this.pageController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeBloc bloc = HomeModule.to.bloc<HomeBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            pageController.nextPage(
                curve: Curves.ease, duration: Duration(milliseconds: 500));
          },
        ),
        StreamBuilder<MesModel>(
            stream: bloc.outPageSel,
            // initialData: "Janeiro/2020",
            builder: (context, snapshot) {
              MesModel data = snapshot.data;
              if (snapshot.hasData) return Text("${data.mes}/${data.ano}");
              return Container();
            }),
        IconButton(
          icon: Icon(Icons.keyboard_arrow_right),
          onPressed: () {
            pageController.previousPage(
                curve: Curves.ease, duration: Duration(milliseconds: 500));
          },
        )
      ],
    );
  }
}
