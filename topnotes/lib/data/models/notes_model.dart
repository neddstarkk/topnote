import 'package:topnotes/data/models/folder_model.dart';
import 'package:topnotes/data/models/tags_model.dart';

import 'package:topnotes/data/repository/folder_repository.dart';

final Folder allNotes = repo.folders[0];

class Note {
  String noteId;
  String title;
  String content;

  List<Folder> associatedFolders;
  List<Tag> associatedTags;
  DateTime timeStamp;

  bool isFavorite;

  Note({
    List<Folder> associatedFolders,
    List<Tag> associatedTags,
    String noteId,
    String content,
    String title,
    DateTime timeStamp,
    bool isFavorite,
  })  : this.associatedFolders =
            associatedFolders != null ? associatedFolders : [repo.folders[0]],
        this.associatedTags = associatedTags != null ? associatedTags : [],
        this.noteId = noteId != null ? noteId : DateTime.now().toString(),
        this.timeStamp = timeStamp != null ? timeStamp : DateTime.now(),
        this.isFavorite = isFavorite != null ? isFavorite : false,
        this.title = title != null ? title : '',
        this.content = content != null ? content : '';
}
