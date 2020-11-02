import 'package:bloc/bloc.dart';
import 'package:topnotes/data/models/tags_model.dart';


class TagCubit extends Cubit<List<Tag>> {
  List<Tag> tagList = [];
  TagCubit() : super([]);

  void addNewTag() {}
}
