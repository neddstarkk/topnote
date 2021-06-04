import 'package:flutter/material.dart';
import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/internal/size_config.dart';

Widget showAssociatedTags(Tag tag) {
  return Container(
    height: SizeConfig.blockSizeVertical * 3,
    margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 1.5),
    child: Container(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeVertical * 2)
      ),
      child: Center(
        child: Text(
          "#${tag.tagName}",
          style: TextStyle(
          ),
        ),
      ),
    ),
  );
}
