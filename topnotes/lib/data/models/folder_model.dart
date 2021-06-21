import 'package:flutter/material.dart';
import 'package:topnotes/data/models/notes_model.dart';

class Folder {
  int folderId;
  String folderName;
  String typeOfFolder;
  List<Note> notesUnderFolder;
  Icon icon;

  Folder({
    @required this.folderName,
    this.typeOfFolder,
    @required this.notesUnderFolder,
    this.icon,
  });
}
