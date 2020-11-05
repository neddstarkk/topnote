import 'package:flutter/material.dart';
import 'package:topnotes/internal/size_config.dart';
import 'package:topnotes/ui/widgets/new_note_widgets/content_textfield.dart';
import 'package:topnotes/ui/widgets/new_note_widgets/title_textfield.dart';

class NewNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
            child: Icon(Icons.favorite_border_outlined,),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3),
        child: Column(
          children: [
            // title textfield
            TitleTextField(),

            // content textfield,
            ContentTextField(),
          ],
        ),
      ),
    );
  }
}
