import 'package:controlefinanceiroapp/app/app_module.dart';
import 'package:controlefinanceiroapp/app/modules/home/home_bloc.dart';
import 'package:controlefinanceiroapp/app/modules/home/home_module.dart';
import 'package:controlefinanceiroapp/app/shared/models/registro_model.dart';
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
      body: StreamBuilder<List<RegistroModel>>(
        stream: bloc.outRegistros,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return createTable(snapshot.data);
          else if (snapshot.hasError) return Text(snapshot.error.toString());
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year}";
  }

  Table createTable(List<RegistroModel> registros) {
    return Table(
      // border: TableBorder(
      //   horizontalInside: BorderSide(
      //     color: Colors.black,
      //     style: BorderStyle.solid,
      //     width: 1.0,
      //   ),
      //   verticalInside: BorderSide(
      //     color: Colors.black,
      //     style: BorderStyle.solid,
      //     width: 1.0,
      //   ),
      // ),
      children: registros
          .map<TableRow>((registro) => _createTableLine(registro))
          .toList(),
    );
  }

  _createTableLine(RegistroModel registro) {
    return TableRow(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            formatDate(registro.data),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            registro.valor > 0
                ? "R\$ ${registro.valor.toStringAsFixed(2).replaceAll(".", ",")}"
                : "- R\$ ${registro.valor.abs().toStringAsFixed(2).replaceAll(".", ",")}",
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16,
              color: registro.valor < 0 ? Colors.red : Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            registro.descricao,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
