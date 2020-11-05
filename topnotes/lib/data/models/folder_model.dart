import 'package:flutter/material.dart';

class Folder {
  int folderId;
  String folderName;
  String typeOfFolder;
  List notesUnderFolder;

  Folder({@required this.folderName, this.typeOfFolder, this.notesUnderFolder});
}
