import 'package:flutter/material.dart';
import 'package:topnotes/data/models/notes_model.dart';
import 'package:topnotes/internal/constants.dart';
import 'package:topnotes/internal/size_config.dart';

class TitleTextField extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();

  final Note note;
  TitleTextField({@required this.note});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      controller: titleController,
      textCapitalization: TextCapitalization.sentences,
      style: noteTitleTextStyle.copyWith(
        fontSize: SizeConfig.blockSizeVertical * 2,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintText: "Title",
        hintStyle: noteTitleTextStyle.copyWith(
            fontSize: SizeConfig.blockSizeVertical * 2),
        border: InputBorder.none,
      ),
      onChanged: (text) {
        // if this is a new note and a change has just been made.
        if(titleController.text.length == 1 && note == null) {
          // TODO: Assign a nodeID, update title, associate folder general,
        }
        // a note object exists
        else {
          print(text);
        }
      },
    );
  }
}
