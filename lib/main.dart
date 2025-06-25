import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Profile()
    ));
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'PERSONAL INFORMATION',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            color: Colors.cyanAccent,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 8,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Container(
              child: Column(
                children: [

                  Icon(Icons.icecream, size: 100),

                ],
              ),
            ),
            // spaceBetween Example
            Container(
              width: 300,
              height: 75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Name:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'France Joseph Cabral',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),



            // spaceEvenly Example
            Container(
              width: 300,
              height: 75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Email:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'francejosephcabral@gmail.com',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),


            // spaceAround Example

            Container(
              width: 300,
              height: 75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Company:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Batangas State University TNEU ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),Container(
              width: 300,
              height: 75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Contact Number:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '091222222222',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 100),
              width: 300, // Optional padding around the button
              child: ElevatedButton(
                onPressed: () {
                  // Add your logout action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Button background color
                  foregroundColor: Colors.white, // Text (and icon) color
                  elevation: 5, // Shadow depth
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text('   Logout     '), // Button text
              ),
            ),

          ],
        ),
      ),
    );
  }
}
