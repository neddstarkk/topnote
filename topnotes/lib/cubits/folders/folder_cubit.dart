import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:topnotes/data/models/folder_model.dart';
import 'package:topnotes/data/models/notes_model.dart';
import 'package:topnotes/data/repository/folder_repository.dart';

class FolderCubit extends Cubit<List<Folder>> {
  List<Folder> folderList = repo.folders;

  FolderCubit() : super(repo.folders);

  void addNewFolder(String text) {
    Folder folder = Folder(
      folderName: "$text",
      typeOfFolder: "Normal",
      notesUnderFolder: [],
    );
    folderList.insert(folderList.length - 2, folder);

    emit(folderList);
  }

  void addNoteToFolder(String nameOfFolder, Note note) {
    Folder targetFolder =
        folderList.firstWhere((folder) => folder.folderName == nameOfFolder);

    targetFolder.notesUnderFolder.add(note);

    emit(folderList);
  }

  void updateNote(String nameOfFolder, Note note) {

    var targetFolders = folderList.where((element) => note.associatedFolders.contains(element));

    for(var folder in targetFolders) {
      var targetNote = folder.notesUnderFolder.firstWhere((element) => element.noteId == note.noteId);
      folder.notesUnderFolder.remove(targetNote);
      targetNote = note;
      folder.notesUnderFolder.add(targetNote);
    }

    emit(folderList);
  }

  void removeNoteFromFolder(String nameOfFolder, Note note) {
    Folder targetFolder =
    folderList.firstWhere((folder) => folder.folderName == nameOfFolder);

    targetFolder.notesUnderFolder.removeWhere((element) => element.noteId == note.noteId);

    emit(folderList);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is List<Folder> && ListEquality().equals(other, folderList);
  }

  @override
  // TODO: implement hashCode
  int get hashCode => folderList.hashCode;
}
