import 'package:flutter/material.dart';
import 'package:topnotes/ui/home_screen.dart';

void main() => runApp(TopNotesApp());

class TopNotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF0C1720),
      ),
      home: HomeScreen(),
    );
  }
}
