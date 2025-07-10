import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddBookPage extends StatefulWidget {
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final titleCtrl = TextEditingController();
  final authorCtrl = TextEditingController();
  final yearCtrl = TextEditingController();

  Future<void> addBook() async {
    final res = await http.post(
      Uri.parse('http://10.0.2.2:3000/api/books'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': titleCtrl.text,
        'author': authorCtrl.text,
        'publishedYear': int.tryParse(yearCtrl.text) ?? 0,
      }),
    );
    if (res.statusCode == 201) {
      Navigator.pop(context); // go back to HomePage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('➕ Add New Book')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: authorCtrl,
              decoration: InputDecoration(labelText: 'Author'),
            ),
            TextField(
              controller: yearCtrl,
              decoration: InputDecoration(labelText: 'Published Year'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: addBook, child: Text('Submit')),
          ],
        ),
      ),
    );
  }
}