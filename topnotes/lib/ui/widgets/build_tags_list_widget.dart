import 'package:flutter/material.dart';
import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/internal/utils/constants.dart';

Widget buildTagsList(Tag tag) {
  return ListTile(
    leading: Icon(
      Icons.local_offer_outlined,
      color: tileIconColor,
    ),
    title: Text(
      "${tag.tagName}",
      style: TextStyle(color: Color(0xFF667079)),
    ),
    trailing: Text(
      "${tag.notesUnderTag.length}",
      style: tileTrailTextStyle,
    ),
  );
}