import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config.dart';

class Relatorio extends StatefulWidget {
    final String userName;
  
  Relatorio({Key key, @required this.userName})
      : super(key: key);
  
  
  @override
  _RelatorioState createState() => _RelatorioState();
}

class _RelatorioState extends State<Relatorio> {


  @override
  Widget build(BuildContext context) {
        print("ENTRE");
    print(widget.userName);
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
      child: Text(widget.userName,
      style: getTextStyle(16, false, backColor, "fontFamily"),),
    ),
        ],
      )
      //listValue(),
    );
  }

  getName(){

    return Container(
      child: Text(widget.userName,
      style: getTextStyle(16, false, backColor, "fontFamily"),),
    );
  }

  Future<List> getValue() async {
    final response =
        await http.get("https://bdagencetest.000webhostapp.com/get.php");
    return json.decode(response.body);
  }

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
                    list[i]['no_usuario'],
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
