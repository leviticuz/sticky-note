import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<StickyNote> notes = [StickyNote(), StickyNote()]; // Initial sticky notes

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sticky Note UI',
      home: Scaffold(
        backgroundColor: Color(0xFF10316B),
        appBar: AppBar(
          title: Center(
            child: Text(
              'Sticky Note',
              style: TextStyle(
                color: Color(0xFFFEFFEA), // Title text color
              ),
            ),
          ),
          backgroundColor: Color(0xFF10316B),
          elevation: 0,
        ),
        body: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF10316B),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
                      child: notes[index].withDeleteButton(() {
                        setState(() {
                          notes.removeAt(index); // Remove the sticky note
                        });
                      }),
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        notes.add(StickyNote()); // Add a new StickyNote to the list
                      });
                    },
                    iconSize: 30, // Size of the icon
                    padding: EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StickyNote extends StatefulWidget {
  @override
  _StickyNoteState createState() => _StickyNoteState();

  // Method to wrap the StickyNote with a delete button
  Widget withDeleteButton(VoidCallback onDelete) {
    return Stack(
      children: [
        this,
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: Icon(Icons.close, color: Colors.red),
            onPressed: onDelete,
          ),
        ),
      ],
    );
  }
}

class _StickyNoteState extends State<StickyNote> {
  bool _isChecked = false; // State for the checkbox
  final TextEditingController _controller = TextEditingController(
    text: '',
  );
  final TextEditingController _titleController = TextEditingController(
    text: '',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1500,
      height: 200,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFED78),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: _isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value ?? false;
                  });
                },
              ),
              Expanded(
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title...',
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 12), // Smaller font
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14, // Smaller font
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter note content here...',
                hintStyle: TextStyle(color: Colors.black54, fontSize: 12), // Smaller font
              ),
              style: TextStyle(
                fontSize: 12, // Smaller font
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
