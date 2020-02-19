import 'package:agence_test/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'drawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'home_components/relatorio.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  double maxWidth;
  int segmentedControl;
  String tittle;
  String _dateBigin = "Periodo de Inicio";
  String _dateEnd = "Periodo de Final";
  DateTime dateStart;
  DateTime dateFinish;

  Future<List>getData() async {
    final response =
        await http.get("http://bdagencetest.000webhostapp.com/get.php");
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

  void postValue() {
    print("ENTRE");
    print(dateStart);
    print(dateFinish);
    String url = "http://bdagencetest.000webhostapp.com/relatorio.php";
    http.post(url, body: {
      "dateBigin": dateStart.toString(),
      "dateEnd": dateFinish.toString()
    });
    //final response = await http.post(url,body: {"biginDate":"2003/1/1","endDate":"2007/12/31"});
    //   print(json.decode(response.body));
  }

  Widget itemList(list) {
    return new ListView.builder(
      shrinkWrap: false,
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        String userName = list[i]['no_usuario'];
        return new Container(
            padding: const EdgeInsets.all(10.0),
            child: segmentedControl == 0
                ? Row(
                    children: <Widget>[
                      Container(
                        height: 30,
                        child: Text(
                          userName,
                          style: getTextStyle(
                              15, false, Colors.black, "fontFamily"),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                postValue();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Relatorio(
                                            userName: list[i]['no_usuario'],
                                            userCoName: list[i]['co_usuario'],
                                            )));
                              },
                              child: Container(
                                child: Icon(Icons.table_chart),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                margin: EdgeInsets.all(5),
                                child: Icon(Icons.insert_chart),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                child: Icon(Icons.pie_chart),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                : Container());
      },
    );
  }

  Widget list1() {
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

  selecDateRange(dateStart, dateFinish) {}

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
            Column(
              children: <Widget>[
                //BIGIN DATE
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  elevation: 0,
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        theme: DatePickerTheme(
                          containerHeight: 210.0,
                        ),
                        showTitleActions: true,
                        minTime: DateTime(2003, 1, 1),
                        maxTime: DateTime(2007, 12, 31),
                        onConfirm: (dateBigin) {
                      print('confirm $dateBigin');
                      _dateBigin =
                          '${dateBigin.year} - ${dateBigin.month} - ${dateBigin.day}';
                      setState(() {
                        dateStart = dateBigin;
                        print(dateStart);
                      });
                    },
                        currentTime: DateTime(2007, 12, 31),
                        locale: LocaleType.en);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.date_range,
                                    size: 18.0,
                                    color: backColor,
                                  ),
                                  Text(
                                    " $_dateBigin",
                                    style: TextStyle(
                                        color: backColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "  Change",
                          style: TextStyle(
                              color: backColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
                //END DATE
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  elevation: 0,
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        theme: DatePickerTheme(
                          containerHeight: 210.0,
                        ),
                        showTitleActions: true,
                        minTime: DateTime(2003, 1, 1),
                        maxTime: DateTime(2007, 12, 31), onConfirm: (dateEnd) {
                      print('confirm $dateEnd');
                      _dateEnd =
                          '${dateEnd.year} - ${dateEnd.month} - ${dateEnd.day}';
                      setState(() {
                        dateFinish = dateEnd;
                        print(dateFinish);
                      });
                    },
                        currentTime: DateTime(2007, 12, 31),
                        locale: LocaleType.en);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.date_range,
                                    size: 18.0,
                                    color: backColor,
                                  ),
                                  Text(
                                    " $_dateEnd",
                                    style: TextStyle(
                                        color: backColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "  Change",
                          style: TextStyle(
                              color: backColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
              ],
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
            Expanded(child: list1())
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
