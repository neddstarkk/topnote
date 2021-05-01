import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/internal/size_config.dart';
import 'package:topnotes/ui/widgets/new_note_widgets/alert_dialog_tags.dart';
import 'package:topnotes/ui/widgets/new_note_widgets/associated_tags_widget.dart';
import 'package:topnotes/ui/widgets/new_note_widgets/content_textfield.dart';
import 'package:topnotes/ui/widgets/new_note_widgets/title_textfield.dart';

class NotePage extends StatefulWidget {


  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  List<Tag> associatedTagsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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

            // associated tags Container

            Container(
              child: Row(
                children: [
                  if (associatedTagsList.isNotEmpty)
                    for (var tag in associatedTagsList) showAssociatedTags(tag),
                ],
              ),
            ),

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
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal,
                      ),
                      ButtonTheme(
                        minWidth: SizeConfig.blockSizeHorizontal * 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.blockSizeVertical * 5)),
                        child: TextButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.check_box_outlined,
                            color: Colors.white70,
                          ),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.all(0.0)),
                            backgroundColor: MaterialStateProperty.all(Colors.white70),
                          ),
                        ),
                      ),
                      ButtonTheme(
                        minWidth: SizeConfig.blockSizeHorizontal * 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.blockSizeVertical * 5)),
                        child: TextButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.image_outlined,
                            color: Colors.white70,
                          ),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.all(0.0)),
                            backgroundColor: MaterialStateProperty.all(Colors.white70),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // this container will allow user to toggle the bottomsheet that
                // provides further options to add tags and add note to folder.
                Container(
                  height: SizeConfig.blockSizeVertical * 5,
                  width: SizeConfig.blockSizeVertical * 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(SizeConfig.blockSizeVertical * 1.6),
                    ),
                  ),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(SizeConfig.blockSizeVertical * 1.6),
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                                height: SizeConfig.blockSizeVertical * 12,
                                width: SizeConfig.screenWidth,
                                color: Color(0xFF1A2B37),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: Icon(
                                        Icons.folder_open_outlined,
                                        color: Color(0xFF2F4E60),
                                      ),
                                      title: Text(
                                        "Add to folder",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.local_offer_outlined,
                                        color: Color(0xFF2F4E60),
                                      ),
                                      title: Text(
                                        "Add tags",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => addTagsToNote(),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ));
                    },
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addTagsToNote() {
    return AlertDialogTags(associatedTagsList: associatedTagsList,);
  }
}
