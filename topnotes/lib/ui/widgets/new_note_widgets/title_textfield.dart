import 'package:flutter/material.dart';
import 'package:topnotes/internal/constants.dart';
import 'package:topnotes/internal/size_config.dart';

class TitleTextField extends StatelessWidget {
  final TextEditingController titleController;

  TitleTextField({this.titleController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      controller: titleController,
      textCapitalization: TextCapitalization.sentences,
      style: noteTitleTextStyle.copyWith(fontSize: SizeConfig.blockSizeVertical * 2),
      decoration: InputDecoration(
        hintText: "Title",
        hintStyle: noteTitleTextStyle.copyWith(
            fontSize: SizeConfig.blockSizeVertical * 2),
        border: InputBorder.none,
      ),
    );
  }
}
