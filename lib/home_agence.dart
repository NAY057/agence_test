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

  Center segmentedControlConfig(String text) {
    return Center(
      child: Container(
        width: (maxWidth / 2) - 10,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 12,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  updateListview(int index) {
    setState(() {
      segmentedControl = index;
    });
    switch (segmentedControl) {
      case 0:
        break;

      case 1:
        break;
    }
  }

  @override
  void initState() {
    _scaffoldKey = new GlobalKey();
    segmentedControl = 0;
    updateListview(segmentedControl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        body: Center(
          child: CupertinoSegmentedControl<int>(
            borderColor: themeColor,
            children: {
              0: segmentedControlConfig("PENDIENTES"),
              1: segmentedControlConfig("REALIZADOS"),
            },
            onValueChanged: (index) => updateListview(index),
            groupValue: segmentedControl,
            selectedColor: themeColor,
            pressedColor: Colors.white,
            unselectedColor: Colors.white,
            padding: EdgeInsets.all(0),
          ),
        ));
  }
}
