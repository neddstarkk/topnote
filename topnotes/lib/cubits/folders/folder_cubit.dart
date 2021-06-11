import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:topnotes/data/models/folder_model.dart';
import 'package:topnotes/data/models/notes_model.dart';
import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/data/repository/folder_repository.dart';

class FolderCubit extends Cubit<List<Folder>> {
  List<Folder> folderList = repo.folders;

  FolderCubit() : super(repo.folders);

  void addNewFolder(String text) {
    Folder folder = Folder(
      folderName: "$text",
      typeOfFolder: "UC", // User Created
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

  void updateNote(Note note) {
    var targetFolders =
        folderList.where((element) => note.associatedFolders.contains(element));

    for (var folder in targetFolders) {
      var targetNote = folder.notesUnderFolder
          .firstWhere((element) => element.noteId == note.noteId);
      folder.notesUnderFolder.remove(targetNote);
      targetNote = note;
      folder.notesUnderFolder.add(targetNote);
    }

    emit(folderList);
  }

  void favoriteNote(Note note) {
    updateNote(note);
    Folder favFolder =
        folderList.firstWhere((element) => element.folderName == "Favorites");
    var contain = favFolder.notesUnderFolder
        .where((element) => element.noteId == note.noteId);
    if (favFolder.notesUnderFolder.isEmpty || contain.isEmpty) {
      addNoteToFolder('Favorites', note);
    } else if (contain.isNotEmpty) {
      removeNoteFromFolder('Favorites', note);
    }
  }

  void removeNoteFromFolder(String nameOfFolder, Note note) {
    Folder targetFolder =
        folderList.firstWhere((folder) => folder.folderName == nameOfFolder);

    targetFolder.notesUnderFolder
        .removeWhere((element) => element.noteId == note.noteId);

    emit(folderList);
  }

  void removeTagFromNote(Tag tag, Note note) {
    var targetFolders =
        folderList.where((element) => element.notesUnderFolder.contains(note));

    for (var folder in targetFolders) {
      Note targetNote =
          folder.notesUnderFolder.firstWhere((element) => element == note);
      targetNote.associatedTags.remove(tag);
    }

    emit(folderList);
  }

  void moveNoteToTrash(Note note) {
    var targetFolders =
        folderList.where((element) => note.associatedFolders.contains(element));

    for (var folder in targetFolders) {
      var targetNote = folder.notesUnderFolder
          .firstWhere((element) => element.noteId == note.noteId);
      folder.notesUnderFolder.remove(targetNote);
    }

    addNoteToFolder('Trash', note);
  }

  void emptyFolder(String folderName) {
    Folder targetFolder =
        folderList.firstWhere((folder) => folder.folderName == folderName);
    targetFolder.notesUnderFolder = [];

    emit(folderList);
  }

  bool checkNoteInFolder(String nameOfFolder, Note note) {
    Folder targetFolder =
        folderList.firstWhere((folder) => folder.folderName == nameOfFolder);

    return targetFolder.notesUnderFolder.contains(note);
  }

  get folders => folderList;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is List<Folder> && ListEquality().equals(other, folderList);
  }

  @override
  // TODO: implement hashCode
  int get hashCode => folderList.hashCode;
}
