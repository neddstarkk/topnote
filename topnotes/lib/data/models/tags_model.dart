import 'package:flutter/material.dart';

class Tag {
  int tagId;
  String tagName;
  List notesUnderTag;

  Tag({@required this.tagName, this.notesUnderTag});
}