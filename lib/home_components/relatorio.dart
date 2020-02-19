import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config.dart';

class Relatorio extends StatefulWidget {
  final String userName;
  final String userCoName;

  Relatorio(
      {Key key,
      @required this.userName,
      this.userCoName})
      : super(key: key);

  @override
  _RelatorioState createState() => _RelatorioState();
}

class _RelatorioState extends State<Relatorio> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backColor,
          centerTitle: true,
          title: Text(
            "Relatorio",
            style: getTextStyle(35, true, themeColor, "fontFamily"),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
                //child: getName()
                ),
            Expanded(child: listValue())
          ],
        )
        //listValue(),
        );
  }

  getName() {
    return Column(
      children: <Widget>[
        Container(
          child: Text(
            widget.userName,
            style: getTextStyle(16, false, backColor, "fontFamily"),
          ),
        ),
      ],
    );
  }

  Future<List>getValue() async {
    final response =
        await http.get("http://bdagencetest.000webhostapp.com/relatorio.php");
          json.decode(response.body);
    return json.decode(response.body);
  }

/*   void postValue()  {
    print("ENTRE");
    print(widget.dateBigin);
    print(widget.dateEnd);
    String url = "http://bdagencetest.000webhostapp.com/relatorio.php";
    http.post(url, body: {
      "dateBigin": DateTime.parse(widget.dateBigin.toString()),
      "dateEnd": DateTime.parse(widget.dateEnd.toString())
    });
    //final response = await http.post(url,body: {"biginDate":"2003/1/1","endDate":"2007/12/31"});
    //   print(json.decode(response.body));
  } */

/*     void editarUsuario() {
    var url = "http://192.168.0.11/pruebas/editarUsuario.php";
    http.post(url, body: {
      "idUsuario": widget.lista[widget.index]['idUsuario'],
      "nombre": controlNombre.text,
      "telefono": controlTelefono.text,
      "email": controlEmail.text,
    });
  } */

/*   Future<List> makePostRequest() async {  // set up POST request arguments
  String url = 'https://bdagencetest.000webhostapp.com/relatorio.php';
  Map<String, String> headers = {"Content-type": "application/json"};
  String json = '{"biginDate": "2007/11/11", "endDate": "2007/12/12"}';  // make POST request
  String jsonBody = json.encode(body);
  final response = await http.post(url, headers: headers, body: json); 
    dynamic body = response.body;
    print(body);
    return body;
  } */

  listValue() {
    return new FutureBuilder<List>(
      future: getValue(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? itemList(
                snapshot.data,
              )
            : new Center(
                child: new CircularProgressIndicator(),
              );
      },
    );
  }

  Widget itemList(list) {
    return new ListView.builder(
      shrinkWrap: false,
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Container(
                  height: 30,
                  child: Text(
                    list[i]['valor'],
                    style: getTextStyle(15, false, Colors.black, "fontFamily"),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text("value"),
                      )
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }
}
