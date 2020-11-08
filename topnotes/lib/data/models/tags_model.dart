import 'package:flutter/material.dart';

class Tag {
  int tagId;
  String tagName;
  List notesUnderTag;
  bool isSelected;

  Tag({@required this.tagName, this.notesUnderTag, this.isSelected});
}