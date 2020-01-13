import 'package:controlefinanceiroapp/app/modules/home/home_bloc.dart';
import 'package:controlefinanceiroapp/app/modules/home/home_module.dart';
import 'package:controlefinanceiroapp/app/shared/models/mes_model.dart';
import 'package:flutter/material.dart';

class MovimentationsWidget extends StatelessWidget {
  final PageController pageController;

  const MovimentationsWidget({Key key, this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = HomeModule.to.bloc<HomeBloc>();
    return Expanded(
      child: StreamBuilder<List<MesModel>>(
        stream: bloc.outMeses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              reverse: true,
              controller: pageController,
              itemCount: bloc.pages.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child:
                      Text("${bloc.pages[index].mes}/${bloc.pages[index].ano}"),
                );
              },
              onPageChanged: (pos) {
                print(bloc.pages[pos].mes);
                bloc.inPageSel.add(bloc.pages[pos]);
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
