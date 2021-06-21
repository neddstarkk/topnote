import 'package:flutter/material.dart';
import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/internal/size_config.dart';

class AssociatedTags extends StatelessWidget {
  final Tag tag;
  const AssociatedTags(this.tag, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 3,
      margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 1.5),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 2),
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(SizeConfig.blockSizeVertical * 2)),
        child: Center(
          child: Text(
            "#${tag.tagName}",
            style: TextStyle(),
          ),
        ),
      ),
    );
  }
}
