import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.teal[700],
      appBar: AppBar(
        title: Text(
          'Chords Changer',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Centers the Column vertically
          children: [
            // First Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,  // Centers the text horizontally in this column
              children: [
                Center(
                  child: Text(
                    'Column 1 - Item 1',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Center(
                  child: Text(
                    'Column 1 - Item 2',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Add spacing between columns

            // Second Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,  // Centers the text horizontally in this column
              children: [
                Center(
                  child: Text(
                    'Column 2 - Item 1',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Center(
                  child: Text(
                    'Column 2 - Item 2',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ));
}

