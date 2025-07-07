import 'package:flutter/material.dart';
import 'pages/listitem.dart';
import 'pages/add_drink.dart';
import 'Worldtime/home.dart';
import 'Worldtime/choose_location.dart';
import 'Worldtime/loading.dart';
void main() {
  runApp(
    MaterialApp(
      routes: {
        '/list': (context) =>  ListItem(),
        '/add': (context) => const DrinkKinds(),

        //world time routes
        '/home': (context) => Home(),
        '/choose_location':(context) =>ChooseLocation(),
        '/' : (context) => Loading(),

      },
    ),
  );
}