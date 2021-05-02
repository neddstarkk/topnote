import 'package:topnotes/data/models/folder_model.dart';
import 'package:topnotes/data/models/tags_model.dart';

class Note {
  String noteId;
  String title;
  String content;

  String associatedFolder;
  List<Tag> associatedTags;
  DateTime timeStamp;

  bool isFavorite;

  Note({
    this.associatedFolder,
    this.associatedTags,
    this.noteId,
    this.content,
    this.title,
    this.timeStamp,
    this.isFavorite
  });
}
