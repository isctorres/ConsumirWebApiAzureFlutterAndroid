import 'package:consumir_web_api/app.dart';
import 'package:consumir_web_api/ui/charts/grafica1.dart';
import 'package:consumir_web_api/ui/charts/grafica2.dart';
import 'package:consumir_web_api/ui/charts/grafica3.dart';
import 'package:consumir_web_api/ui/charts/grafica4.dart';
import 'package:consumir_web_api/ui/charts/grafica5.dart';
import 'package:consumir_web_api/ui/home/home_screen.dart';
import 'package:consumir_web_api/ui/views/custom_widgets.dart';
import 'package:flutter/material.dart';
 
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.orangeAccent
      ),
      routes: {
        '/list'   : (context) => App(),
        '/chart1' : (context) => Grafica1(), 
        '/chart2' : (context) => Grafica2(), 
        '/chart3' : (context) => Grafica3(), 
        '/chart4' : (context) => Grafica4(), 
        '/chart5' : (context) => Grafica5(), 
      },
      title: 'Materias Web Api',
      home: Menu()
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Web Api && Charts Materias',style: TextStyle(color: Colors.white)),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('Rubén Torres Frias'), 
                accountEmail: Text('isctorres@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: new NetworkImage("http://i.pravatar.cc/300"),
                ),
              ),
              itemMenu(titulo: 'Listar Materias',icon: Icons.add_to_home_screen,context: context, ruta:'/list'),
              itemMenu(titulo: 'Grafica 1',icon: Icons.insert_chart,context: context, ruta:'/chart1'),
              itemMenu(titulo: 'Grafica 2',icon: Icons.insert_chart,context: context, ruta:'/chart2'),
              itemMenu(titulo: 'Grafica 3',icon: Icons.insert_chart,context: context, ruta:'/chart3'),
              itemMenu(titulo: 'Grafica 4',icon: Icons.insert_chart,context: context, ruta:'/chart4'),
              itemMenu(titulo: 'Grafica 5',icon: Icons.insert_chart,context: context, ruta:'/chart5'),
            ],
          ),
        ),
        body: Center(
          child: Container(
            child: FlutterLogo(size: 50.0)
          ),
        ),
      );
  }
}