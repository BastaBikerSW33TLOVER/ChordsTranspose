import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart'; // For Clipboard
import 'package:share_plus/share_plus.dart';void main() {
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
  List<FileSystemEntity> savedFiles = [];

  final List<String> chromatic = [
    'C', 'C#', 'D', 'D#', 'E', 'F',
    'F#', 'G', 'G#', 'A', 'A#', 'B'
  ];

  final Map<String, String> flatToSharp = {
    'Db': 'C#', 'Eb': 'D#', 'Gb': 'F#', 'Ab': 'G#', 'Bb': 'A#'
  };

  @override
  void initState() {
    super.initState();
    loadSavedFiles();
  }

  Future<Directory> getAppDir() async {
    return await getApplicationDocumentsDirectory();
  }

  Future<void> saveCurrentChords() async {
    final content = getTransposedOutput().trim();
    print("Saving content:\n$content"); // DEBUG

    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nothing to save')),
      );
      return;
    }

    try {
      final dir = await getAppDir();
      final filename = 'chords_${DateTime.now().millisecondsSinceEpoch}.txt';
      final file = File('${dir.path}/$filename');

      await file.writeAsString(content);
      await Future.delayed(Duration(milliseconds: 100)); // Wait to ensure write is complete
      await loadSavedFiles();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved to $filename')),
      );
    } catch (e) {
      print('Error saving file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving file')),
      );
    }
  }



  Future<void> loadSavedFiles() async {
    final dir = await getAppDir();
    final files = dir.listSync().where((f) => f.path.endsWith('.txt')).toList();
    setState(() {
      savedFiles = files;
    });
  }

  Future<void> deleteFile(File file) async {
    await file.delete();
    await loadSavedFiles();
  }

  Future<String> readFileContent(File file) async {
    return await file.readAsString();
  }

  String getTransposedOutput() {
    final lines = _controller.text.trim().split('\n');

    return lines.map((line) {
      if (line.trim().startsWith('//') || line.trim().isEmpty) return line;

      final tokens = RegExp(r'[A-Ga-g][b#]?[a-zA-Z0-9/()]*|--+|[-–—|]+|\s+')
          .allMatches(line)
          .map((match) => match.group(0)!)
          .toList();

      final transposedLine = tokens.map((token) {
        final trimmed = token.trim();
        if (trimmed == '-' || trimmed == '--' || trimmed == '–' || trimmed == '—' || trimmed == '|') {
          return token;
        }


        final match = RegExp(r'^([A-Ga-g][b#]?)(.*)$').firstMatch(trimmed);
        if (match == null) return token;

        String root = match.group(1)!.toUpperCase();
        String suffix = match.group(2)!;

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

  @override
  Widget build(BuildContext context) {
    final transposedText = getTransposedOutput();

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
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: saveCurrentChords,
              icon: Icon(Icons.save),
              label: Text('Save to File'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: transposedText));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Copied to clipboard')),
                    );
                  },
                  icon: Icon(Icons.copy),
                  label: Text('Copy'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Share.share(transposedText, subject: 'My Transposed Chords');
                  },
                  icon: Icon(Icons.share),
                  label: Text('Share'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Saved Files:', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: savedFiles.length,
                itemBuilder: (context, index) {
                  final file = File(savedFiles[index].path);
                  final filename = file.path.split('/').last;
                  return FutureBuilder(
                    future: readFileContent(file),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListTile(title: Text('Loading...'));
                      }
                      return ListTile(
                        title: Text(filename, style: TextStyle(color: Colors.white)),
                        subtitle: Text(snapshot.data.toString(),
                            style: TextStyle(color: Colors.white70)),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteFile(file),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
