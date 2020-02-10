import 'package:flutter/material.dart';
import 'config.dart';

class BurgerDrawer extends StatefulWidget {
  @override
  _BurgerDrawerState createState() => _BurgerDrawerState();
}

class _BurgerDrawerState extends State<BurgerDrawer> {
  double maxWidthOption;

  @override
  Widget build(BuildContext context) {
    maxWidthOption = MediaQuery.of(context).size.width;
    return Container(
      width: maxWidthOption,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text(
                  "Agence",
                  style: getTextStyle(70, true, themeColor, "fontFamily"),
                ),
              ),
              decoration: BoxDecoration(color: Color(0xff131C2D)),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                size: 30,
              ),
              title: Text(
                "Inicio",
                style: getTextStyle(25, true, backColor, "fontFamily"),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: Icon(
                Icons.assignment_turned_in,
                size: 30,
              ),
              title: Text(
                "Proyectos",
                style: getTextStyle(25, true, backColor, "fontFamily"),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: Icon(
                Icons.border_color,
                size: 30,
              ),
              title: Text(
                "Administrativo",
                style: getTextStyle(25, true, backColor, "fontFamily"),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: Icon(
                Icons.group,
                size: 30,
              ),
              title: Text(
                "Comercial",
                style: getTextStyle(25, true, backColor, "fontFamily"),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: Icon(
                Icons.poll,
                size: 30,
              ),
              title: Text(
                "Financiero",
                style: getTextStyle(25, true, backColor, "fontFamily"),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 30,
              ),
              title: Text(
                "Usuario",
                style: getTextStyle(25, true, backColor, "fontFamily"),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: ListTile(
                leading: Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 30,
                ),
                title: Text(
                  "Salir",
                  style: getTextStyle(25, true, backColor, "fontFamily"),
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
