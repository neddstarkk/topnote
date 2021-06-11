import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/folders/folder_cubit.dart';
import 'package:topnotes/data/models/notes_model.dart';
import 'package:topnotes/data/models/tags_model.dart';


class TagCubit extends Cubit<List<Tag>> {
  List<Tag> tagList = [];
  TagCubit() : super([]);

  void addNewTag(String text) {
    Tag tag = Tag(tagName: text, notesUnderTag: [], isSelected: false);
    tagList.add(tag);

    emit(tagList);
  }

  void addNoteUnderTag(String tagName, Note note) {
    Tag targetTag =
    tagList.firstWhere((tag) => tag.tagName == tagName);

    targetTag.notesUnderTag.add(note);

    emit(tagList);
  }

  void removeNoteFromTag(String tagName, Note note) {
    Tag targetTag =
    tagList.firstWhere((tag) => tag.tagName == tagName);

    targetTag.notesUnderTag.remove(note);

    emit(tagList);
  }

  void deleteTag(String tagName, BuildContext context) {
    Tag targetTag = tagList.firstWhere((element) => element.tagName == tagName);

    for (var i in targetTag.notesUnderTag) {
      removeNoteFromTag(targetTag.tagName, i);
    }

    tagList.remove(targetTag);

    emit(tagList);
  }

  List<Tag> getTagList() {
    return tagList;
  }
}
