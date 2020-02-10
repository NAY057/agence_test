import 'package:agence_test/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'drawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_picker/flutter_picker.dart';

class Home extends StatefulWidget {
  final List list;
  Home({this.list});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  double maxWidth;
  int segmentedControl;
  String tittle;
  String newsType;
  List list;

/*   Future<List> getData() async {
    //var url = 'http://bdagencetest.000webhostapp.com/get.php';
    var url = "http://192.168.2.100/get.php";
    http.Response response = await http.get(url);
    print("ENTRE");
    Map<String ,dynamic> data = jsonDecode(response.body);
    //print(response.body.toString());
    print(data);
  } */

/*     Future<List>getData(encode) async {

    final response = await http.get("https://bdagencetest.000webhostapp.com/get.php");
    //print(response.body.toString());
    dynamic encode = json.encode(response.body);
    
    //var data = json.decode(encode);
    //Future<List> decodeData;
    //data = decodeData;
    //print(encode);
    return encode;
  } */

/*   Future<List<UserInfo>> getData(newsType) async {
 
    String link = "https://bdagencetest.000webhostapp.com/get.php";
    var res = await http
        .get(Uri.encodeFull(link));
      //print(res.body);
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        var rest = data["UserInfo"] as List;
        print(rest);
        list = rest.map<UserInfo>((json) => UserInfo.fromJson(json)).toList();
      }
      print(list.toString());
    return list;
  } */

  Future<List> getData() async {
    final response =
        await http.get("https://bdagencetest.000webhostapp.com/get.php");
    return json.decode(response.body);
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

  Widget itemList(list) {
    return new ListView.builder(
      shrinkWrap: false,
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
            padding: const EdgeInsets.all(10.0),
            child: segmentedControl == 0
                ? InkWell(
                    child: Container(
                      child: Text(list[i]['no_usuario']),
                    ),
                  )
                : Container());
      },
    );
  }

  Widget list1(list) {
    return new FutureBuilder<List>(
      future: getData(),
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

 showPickerDateRange(BuildContext context) {
    Picker ps = new Picker(
        hideHeader: true,
        adapter: new DateTimePickerAdapter(type: PickerDateTimeType.kYM),
        onConfirm: (Picker picker, List value) {
          //print((picker.adapter as DateTimePickerAdapter).value);
        });

    Picker pe = new Picker(
        hideHeader: true,
        adapter: new DateTimePickerAdapter(type: PickerDateTimeType.kYM),
        onConfirm: (Picker picker, List value) {
          //print((picker.adapter as DateTimePickerAdapter).value);
        });


    List<Widget> actions = [
      FlatButton(
          onPressed: () {
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pop();
              });

          },
          child: new Text(PickerLocalizations.of(context).cancelText)),
      FlatButton(
          onPressed: () {
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pop();
              ps.onConfirm(ps, ps.selecteds);
              pe.onConfirm(pe, pe.selecteds);
              });
          },
          child: new Text(PickerLocalizations.of(context).confirmText))
    ];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text("Select Date Range"),
            actions: actions,
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Begin:"),
                  ps.makePicker(),
                  Text("End:"),
                  pe.makePicker()
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        drawer: BurgerDrawer(),
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
              onTap: () {
                showPickerDateRange(context);
              },
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
            Expanded(child: list1(list))
          ],
        ));
  }
}

/* class ItemList extends StatelessWidget {
  final List list;

  ItemList({this.list,});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: segmentedControl==0? InkWell(
              child:  Container(
                child: Text(list[i]['no_usuario']),
            ),
          ):Container(

          )
        );
      },
    );
  }
} */
