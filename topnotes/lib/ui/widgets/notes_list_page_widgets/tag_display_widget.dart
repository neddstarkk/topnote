import 'package:flutter/material.dart';
import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/internal/size_config.dart';

class TagDisplayWidget extends StatelessWidget {
  const TagDisplayWidget({
    Key key,
    @required this.tag,
  }) : super(key: key);

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
          SizeConfig.blockSizeHorizontal),
      decoration: BoxDecoration(
        color: Color(0xFF687581),
        borderRadius: BorderRadius.circular(
          SizeConfig.blockSizeVertical * 10,
        ),
      ),
      child: Text(
        "#${tag.tagName}",
        style:
        TextStyle(color: Colors.white70),
      ),
    );
  }
}
