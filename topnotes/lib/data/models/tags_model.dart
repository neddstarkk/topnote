import 'package:flutter/material.dart';

import 'notes_model.dart';

class Tag {
  int tagId;
  String tagName;
  List<Note> notesUnderTag;
  bool isSelected;

  Tag({@required this.tagName, this.notesUnderTag, this.isSelected});
}