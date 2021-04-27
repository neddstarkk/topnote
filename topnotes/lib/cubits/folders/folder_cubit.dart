import 'package:bloc/bloc.dart';
import 'package:topnotes/data/models/folder_model.dart';
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
}
