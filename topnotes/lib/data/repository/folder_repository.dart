import 'package:topnotes/data/models/folder_model.dart';

class FolderRepository {
  List<Folder> _folderRepo = [
    Folder(folderName: "hello", notesUnderFolder: []),
    Folder(folderName: "GoodBye", notesUnderFolder: []),
  ];

  List<Folder> get folders => _folderRepo;
}

FolderRepository repo = FolderRepository();