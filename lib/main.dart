import 'package:flutter/material.dart';
import 'package:hahhhahaha/Pages/Listitems.dart';

import 'Pages/AddChords.dart';
import 'Pages/Dashboard.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        '/': (context) => Addchords(),
        '/add': (context) => Listitems()
      },
    ));
}

