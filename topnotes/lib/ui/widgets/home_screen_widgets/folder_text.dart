import 'package:flutter/material.dart';
import 'package:topnotes/internal/constants.dart';
import 'package:topnotes/internal/size_config.dart';

class FolderText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 4,
          bottom: SizeConfig.blockSizeVertical * 2),
      child: Text(
        "Folders",
        style: TextStyle(
            fontSize: SizeConfig.blockSizeVertical * 2),
      ),
    );
  }
}
