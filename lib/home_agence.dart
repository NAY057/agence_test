import 'dart:convert';

import 'package:agence_test/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';
import 'package:http/http.dart' as http;


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  double maxWidth;
  int segmentedControl;
  String tittle;
  List list;
  Future<List> decodeData;

/*   Future<List> getData() async {
    //var url = 'http://bdagencetest.000webhostapp.com/get.php';
    var url = "http://192.168.2.100/get.php";
    http.Response response = await http.get(url);
    print("ENTRE");
    Map<String ,dynamic> data = jsonDecode(response.body);
    //print(response.body.toString());
    print(data);
  } */

    Future<List> getData(Future<List> decodeData) async {
    final response = await http.get("https://bdagencetest.000webhostapp.com/get.php");
    //print(response.body.toString());
    var encode = json.encode(response.body);
    var data = json.decode(encode);
    Future<List> decodeData;
    data = decodeData;
    print(data.toString());
    return data;
  }

  Center segmentedControlConfig(String text) {
    return Center(
      child: Container(
        width: (maxWidth / 2) - 10,
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 12,
              fontFamily: "fontFamily",
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget list1(Future<List> decodeData) {
    return new FutureBuilder<List>(
      future: getData(decodeData),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? ListView.builder(
      itemCount: list == null? 0 : list.length,
      itemBuilder: (context, i){
          print("EEEEEEEENNNTTTRRREEEE");
          print(decodeData);
        return Container(
          child: Text(list[i][decodeData],
          style: getTextStyle(16, false, backColor, "fontFamily"),),
        );
      }
      
      )
            : new Center(
                child: new CircularProgressIndicator(),
              );
      },
    );
  }


  Widget list2() {
    ListView();
  }

  updateListview(int index) {
    setState(() {
      segmentedControl = index;
    });
    switch (segmentedControl) {
      case 0:
        setState(() {
          tittle = "Consultores";
        });
        break;

      case 1:
        setState(() {
          tittle = "Clientes";
        });
        break;
    }
  }

  @override
  void initState() {
    tittle = "Consultores";
    _scaffoldKey = new GlobalKey();
    segmentedControl = 0;
    updateListview(segmentedControl);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        drawer: Burger_drawer(),
        appBar: AppBar(
          backgroundColor: backColor,
          centerTitle: true,
          title: Text(
            "Agence",
            style: getTextStyle(35, true, themeColor, "fontFamily"),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: themeColor,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: CupertinoSegmentedControl<int>(
                borderColor: themeColor,
                children: {
                  0: segmentedControlConfig("Por Consultor"),
                  1: segmentedControlConfig("Por Cliente"),
                },
                onValueChanged: (index) => updateListview(index),
                groupValue: segmentedControl,
                selectedColor: backColor,
                pressedColor: themeColor,
                unselectedColor: themeColor,
                padding: EdgeInsets.all(0),
              ),
            ),
            InkWell(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                color: backColor,
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "Periodo",
                    style: getTextStyle(20, false, themeColor, "fontFamily"),
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    tittle,
                    style: getTextStyle(20, true, backColor, "fontFamily"),
                  ),
                ),
              ],
            ),
            Expanded(child: list1(decodeData)),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(10),
                      color: backColor,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: themeColor,
                        size: 30,
                      )),
                  Container(
                      color: backColor,
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        color: themeColor,
                        size: 30,
                      )),
                ],
              ),
            ),
            Expanded(child: list1(decodeData)),
          ],
        ));
  }
}

/*   class ItemList extends StatelessWidget {
  final List list;
  final Future<List> decodeData;
  ItemList({this.list, this.decodeData});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null? 0 : list.length,
      itemBuilder: (context, i){
          print("EEEEEEEENNNTTTRRREEEE");
          print(decodeData);
        return Container(
          child: Text(list[i][decodeData],
          style: getTextStyle(16, false, backColor, "fontFamily"),),
        );
      }
      
      );
  }
  } */





