import 'package:flutter/material.dart';

class Folder {
  String folderName;
  String typeOfFolder;
  List notesUnderFolder;

  Folder({@required this.folderName, this.typeOfFolder, this.notesUnderFolder});
}
