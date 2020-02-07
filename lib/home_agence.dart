import 'package:agence_test/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  double maxWidth;
  int segmentedControl;
  String tittle;

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

  Widget list1() {
    return ListView(
      children: <Widget>[],
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
            Expanded(child: list1()),
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "agregar",
                    style: getTextStyle(15, false, backColor, "fontFamily"),
                  ),
                ),
                Container(
                  child: Text(
                    "quitar",
                    style: getTextStyle(15, false, backColor, "fontFamily"),
                  ),
                ),
              ],
            ),
            Expanded(child: list1()),
          ],
        ));
  }
}
