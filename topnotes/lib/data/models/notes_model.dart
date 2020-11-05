import 'package:topnotes/data/models/folder_model.dart';
import 'package:topnotes/data/models/tags_model.dart';

class Note{
  String noteId;
  String title;
  String content;


  Folder associatedFolder;
  List<Tag> associatedTags;
  DateTime timeStamp;
}