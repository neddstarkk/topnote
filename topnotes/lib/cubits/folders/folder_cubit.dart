import 'package:bloc/bloc.dart';
import 'package:topnotes/data/models/folder_model.dart';

class FolderCubit extends Cubit<List<Folder>> {
  List<Folder> folderList = [];
  FolderCubit() : super([]);


  void changeState(String text) {
    Folder folder = Folder(
      folderName: "$text",
      typeOfFolder: "Normal",
      notesUnderFolder: [],
    );
    folderList.add(folder);

    emit(folderList);
  }
}
