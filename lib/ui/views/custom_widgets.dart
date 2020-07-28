import 'package:flutter/material.dart';

Widget itemMenu({String titulo, IconData icon, BuildContext context, String ruta}){
    return ListTile(
              title: Text(titulo),
              trailing: Icon(Icons.contacts),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, ruta);
              },
            );
  }
