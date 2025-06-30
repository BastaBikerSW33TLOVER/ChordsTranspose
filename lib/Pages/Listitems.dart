import 'package:flutter/material.dart';
import 'package:hahhhahaha/Pages/ItemCard.dart';

import 'Chords.dart';

class Listitems extends StatefulWidget {
  const Listitems({super.key});

  @override
  State<Listitems> createState() => _ListitemsState();
}

class _ListitemsState extends State<Listitems> {


  List<Chords> chords = [

    Chords(title: 'Larawang kupas', key: 'C#'),
    Chords(title: 'Gintong Araw', key: 'G'),
    Chords(title: 'Kastilyong Buhangin', key: 'C'),
    Chords(title: 'Remember Me', key: 'E'),
    Chords(title: 'Magbalik', key: 'A'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Chords Transpose',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white
          ),),


      ),
        body: Column( children: chords.map((chord){
        return Itemcard(chords: chord);
        }).toList(),
      ),



    );
  }
}

