import 'package:agence_test/config.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey;



  @override
  void initState() {
    _scaffoldKey = new GlobalKey();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Burger_drawer(
      ),
      appBar: AppBar(
        backgroundColor: backColor,
        centerTitle: true,
        title: Text("Agence",
        style: getTextStyle(35, true, themeColor, "fontFamily"),),
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
      
    );
  }
}