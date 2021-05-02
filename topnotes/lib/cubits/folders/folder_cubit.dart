import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
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
    folderList.add(folder);

    emit(folderList);
  }

  void addNoteToFolder(String nameOfFolder, Note note) {
    var targetFolder =
        folderList.firstWhere((folder) => folder.folderName == nameOfFolder);

    targetFolder.notesUnderFolder.add(note);

    print("Reached here");

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
