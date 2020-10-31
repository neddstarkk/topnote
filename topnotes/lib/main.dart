import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/folders/folder_cubit.dart';
import 'package:topnotes/ui/home_screen.dart';

void main() => runApp(SpecialClass());

class SpecialClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FolderCubit>(
      create: (context) => FolderCubit(),
      child: TopNotesApp(),
    );
  }
}

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
