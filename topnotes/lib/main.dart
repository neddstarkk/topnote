import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/folders/folder_cubit.dart';
import 'package:topnotes/ui/screens/home_screen.dart';

import 'cubits/tags/tag_cubit.dart';

void main() => runApp(SpecialClass());

class SpecialClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FolderCubit>(
      create: (context) => FolderCubit(),
      child: BlocProvider<TagCubit>(
        create: (context) => TagCubit(),
        child: TopNotesApp(),
      ),
    );
  }
}

class TopNotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF1F1F1F),
        backgroundColor: Color(0xFF1F1F1F),
        primaryColor: Color(0xFFBEBEDF),
        brightness: Brightness.dark,
      ),
      home: HomeScreen(),
    );
  }
}
