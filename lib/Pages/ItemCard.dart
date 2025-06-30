

import 'package:flutter/material.dart';
import 'package:hahhhahaha/Pages/Chords.dart';

class Itemcard extends StatelessWidget {
  final Chords chords;

  const Itemcard({
    super.key,
    required this.chords,
  });

  @override
  Widget build(BuildContext context) {

    Decoration
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),

      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images.jpg'), // Background image
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3), // Darkens background
              BlendMode.darken,
            ),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        width: 325,
        height: 150,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      chords.title.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),

                    ),
                    const SizedBox(height: 8),
                    Text(
                      chords.key,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),

                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
