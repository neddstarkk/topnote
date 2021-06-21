import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:topnotes/data/models/notes_model.dart';
import 'package:topnotes/internal/constants.dart';
import 'package:topnotes/internal/size_config.dart';

import 'note_operations.dart';
import 'note_taking_mechanisms.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final Note note;

  const CustomBottomNavigationBar({Key key, @required this.note})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
      child: BottomAppBar(
        child: Container(
          color: AppColors.backgroundColor.withAlpha(210),
          height: SizeConfig.blockSizeVertical * 5,
          width: SizeConfig.screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // this container will contain different types of
              // note taking mechanisms like lists, images from gallery etc
              NoteTakingMechanisms(),

              // this container will allow user to toggle the bottomsheet that
              // provides further options to add tags and add note to folder.
              NoteOperations(
                note: note != null ? note : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
