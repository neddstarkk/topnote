import 'package:flutter/material.dart';
import 'package:topnotes/data/models/folder_model.dart';

class FolderRepository {
  List<Folder> _folderRepo = [
    Folder(folderName: "All Notes", notesUnderFolder: [], typeOfFolder: 'ND'),
    Folder(folderName: 'Favorites', notesUnderFolder: [], icon: Icon(Icons.star_border_outlined, color: Colors.yellowAccent), typeOfFolder: 'ND'),
    Folder(folderName: 'Trash', notesUnderFolder: [], icon: Icon(Icons.delete_outline, color: Colors.red,), typeOfFolder: "ND"),

  ];

  List<Folder> get folders => _folderRepo;
}

FolderRepository repo = FolderRepository();