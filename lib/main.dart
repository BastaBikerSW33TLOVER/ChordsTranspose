import 'package:flutter/material.dart';

void main() {
  runApp(ChordTransposerApp());
}

class ChordTransposerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chord Transposer',
      theme: ThemeData.dark(),
      home: ChordTransposerScreen(),
    );
  }
}

class ChordTransposerScreen extends StatefulWidget {
  @override
  State<ChordTransposerScreen> createState() => _ChordTransposerScreenState();
}

class _ChordTransposerScreenState extends State<ChordTransposerScreen> {
  final TextEditingController _controller = TextEditingController();
  int _semitoneShift = 0;

  final List<String> chromatic = [
    'C', 'C#', 'D', 'D#', 'E', 'F',
    'F#', 'G', 'G#', 'A', 'A#', 'B'
  ];

  final Map<String, String> flatToSharp = {
    'Db': 'C#', 'Eb': 'D#', 'Gb': 'F#', 'Ab': 'G#', 'Bb': 'A#'
  };

  String transposeChord(String chord, int shift) {
    final match = RegExp(r'^([A-G][b#]?)(.*)$').firstMatch(chord);
    if (match == null) return chord;

    String root = match.group(1)!;
    String suffix = match.group(2)!;

    // Convert flats to sharps
    if (flatToSharp.containsKey(root)) {
      root = flatToSharp[root]!;
    }

    int index = chromatic.indexOf(root);
    if (index == -1) return chord;

    int newIndex = (index + shift) % 12;
    if (newIndex < 0) newIndex += 12;

    return chromatic[newIndex] + suffix;
  }

  String getTransposedOutput() {
    final lines = _controller.text.trim().split('\n');

    return lines.map((line) {
      // Keep comments or empty lines unchanged
      if (line.trim().startsWith('//') || line.trim().isEmpty) {
        return line;
      }

      // Split by space (preserve '-', '|', etc.)
      final tokens = line.split(RegExp(r'(\\s+)')); // keeps spaces too

      final transposedLine = tokens.map((token) {
        final trimmed = token.trim();
        if (trimmed == '-' || trimmed == '|' || trimmed.isEmpty) {
          return token; // preserve spacing, dashes, etc.
        }

        final match = RegExp(r'^([A-Ga-g][b#]?)(.*)$').firstMatch(trimmed);
        if (match == null) return token;

        String root = match.group(1)!.toUpperCase();
        String suffix = match.group(2)!;

        // Convert flats to sharps
        if (flatToSharp.containsKey(root)) root = flatToSharp[root]!;

        int index = chromatic.indexOf(root);
        if (index == -1) return token;

        int newIndex = (index + _semitoneShift) % 12;
        if (newIndex < 0) newIndex += 12;

        return token.replaceFirst(match.group(1)!, chromatic[newIndex]);
      }).join('');
      return transposedLine;
    }).join('\n');
  }

  void shiftSemitone(int delta) {
    setState(() {
      _semitoneShift += delta;
    });
  }

  @override
  Widget build(BuildContext context) {
    final input = _controller.text;
    final lines = input.split('\n');

    final transposedText = lines.map((line) {
      if (line.trim().startsWith('//') || line.trim().isEmpty) {
        return line; // keep comments or blank lines
      }

      // Match chords like C, C#m, Bb7, F#maj7 — anything that starts with a chord root
      final chordRegex = RegExp(r'([A-Ga-g][b#]?[^-\s]*)');

      return line.replaceAllMapped(chordRegex, (match) {
        String chord = match.group(1)!;

        final matchParts = RegExp(r'^([A-Ga-g][b#]?)(.*)$').firstMatch(chord);
        if (matchParts == null) return chord;

        String root = matchParts.group(1)!.toUpperCase();
        String suffix = matchParts.group(2)!;

        if (flatToSharp.containsKey(root)) {
          root = flatToSharp[root]!;
        }

        int index = chromatic.indexOf(root);
        if (index == -1) return chord;

        int newIndex = (index + _semitoneShift) % 12;
        if (newIndex < 0) newIndex += 12;

        return chromatic[newIndex] + suffix;
      });
    }).join('\n');

    return Scaffold(
      appBar: AppBar(
        title: Text('Chords Transpose'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Enter chords (C--G--Am--F)',
                labelStyle: TextStyle(color: Colors.white70),
              ),
              onChanged: (_) => setState(() {}),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _semitoneShift--),
                  child: Icon(Icons.remove),
                ),
                SizedBox(width: 16),
                Text('Semitones: $_semitoneShift', style: TextStyle(fontSize: 16)),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => setState(() => _semitoneShift++),
                  child: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Transposed Chords:', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                transposedText,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
