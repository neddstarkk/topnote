import 'package:flutter/material.dart';
import 'package:topnotes/internal/constants.dart';
import 'package:topnotes/internal/size_config.dart';

class ContentTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      style: noteTitleTextStyle.copyWith(
        fontSize: SizeConfig.blockSizeVertical * 2,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Content",
        hintStyle: noteContentTextStyle.copyWith(
          fontSize: SizeConfig.blockSizeVertical * 2,
        ),
      ),
    );
  }
}
