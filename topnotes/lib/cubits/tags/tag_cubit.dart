import 'package:bloc/bloc.dart';
import 'package:topnotes/data/models/tags_model.dart';


class TagCubit extends Cubit<List<Tag>> {
  List<Tag> tagList = [];
  TagCubit() : super([]);

  void addNewTag(String text) {
    Tag tag = Tag(tagName: text, notesUnderTag: [], isSelected: false);
    tagList.add(tag);

    emit(tagList);
  }

  List<Tag> getTagList() {
    return tagList;
  }
}
