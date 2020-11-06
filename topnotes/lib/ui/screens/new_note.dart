import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topnotes/internal/size_config.dart';
import 'package:topnotes/ui/widgets/new_note_widgets/bottom_appbar_add_button.dart';
import 'package:topnotes/ui/widgets/new_note_widgets/content_textfield.dart';
import 'package:topnotes/ui/widgets/new_note_widgets/title_textfield.dart';

class NewNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
            child: Icon(
              Icons.favorite_border_outlined,
            ),
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
      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: BottomAppBar(
          color: Color(0xFF1A2B37),
          child: Container(
            height: SizeConfig.blockSizeVertical * 5,
            width: SizeConfig.screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // this container will container different types of
                // note taking mechanisms like lists, images from gallery etc
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: SizeConfig.blockSizeHorizontal,),
                      ButtonTheme(
                        minWidth: SizeConfig.blockSizeHorizontal * 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.blockSizeVertical * 5)),
                        child: FlatButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.check_box_outlined,
                            color: Colors.white70,
                          ),
                          splashColor: Colors.white70,
                          padding: EdgeInsets.all(0.0),
                        ),
                      ),
                      ButtonTheme(
                        minWidth: SizeConfig.blockSizeHorizontal * 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.blockSizeVertical * 5)),
                        child: FlatButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.image_outlined,
                            color: Colors.white70,
                          ),
                          splashColor: Colors.white70,
                          padding: EdgeInsets.all(0.0),
                        ),
                      )
                    ],
                  ),
                ),

                // this container will allow user to toggle the bottomsheet that
                // provides further options to add tags and add note to folder.
                BottomAppBarAddButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
