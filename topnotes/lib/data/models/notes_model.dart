import 'package:topnotes/data/models/folder_model.dart';
import 'package:topnotes/data/models/tags_model.dart';

class Note {
  String noteId;
  String title;
  String content;

  List<Folder> associatedFolders;
  List<Tag> associatedTags;
  DateTime timeStamp;

  bool isFavorite;

  Note({
    this.associatedFolders,
    this.associatedTags,
    this.noteId,
    this.content,
    this.title,
    this.timeStamp,
    this.isFavorite
  });
}
