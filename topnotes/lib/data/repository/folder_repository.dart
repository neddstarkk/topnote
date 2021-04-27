import 'package:topnotes/data/models/folder_model.dart';

class FolderRepository {
  List<Folder> _folderRepo = [
    Folder(folderName: "General", notesUnderFolder: []),
  ];

  List<Folder> get folders => _folderRepo;
}

FolderRepository repo = FolderRepository();