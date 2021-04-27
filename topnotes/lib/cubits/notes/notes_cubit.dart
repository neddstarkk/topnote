import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:topnotes/data/models/notes_model.dart';
import 'package:topnotes/data/models/tags_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  Note note;

  NotesCubit() : super(NotesInitial());

  getTags(String tagName) {

  }
}
