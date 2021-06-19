import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/internal/constants.dart';

class TagsList extends StatelessWidget {
  final Tag _tag;

  const TagsList(this._tag, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.local_offer_outlined,
        color: tileIconColor,
      ),
      title: Text(
        "${_tag.tagName}",
        style: TextStyle(color: Color(0xFF667079)),
      ),
      trailing: Text(
        "${_tag.notesUnderTag.length}",
        style: tileTrailTextStyle,
      ),
    );
  }
}
