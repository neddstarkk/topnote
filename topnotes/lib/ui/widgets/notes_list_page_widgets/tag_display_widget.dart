import 'package:flutter/material.dart';
import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/internal/size_config.dart';

class TagDisplayWidget extends StatelessWidget {
  TagDisplayWidget({@required this.tag});

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 2, vertical: 2),
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Color(0xFF687581),
        borderRadius: BorderRadius.circular(
          SizeConfig.blockSizeVertical * 10,
        ),
      ),
      child: Text(
        "#${tag.tagName}",
        style: TextStyle(color: Colors.white70),
      ),
    );
  }
}
