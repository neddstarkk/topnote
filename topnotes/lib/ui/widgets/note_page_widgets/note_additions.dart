import 'package:flutter/material.dart';
import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/internal/size_config.dart';

import 'alert_dialog_tags.dart';

class NoteAdditions extends StatelessWidget {
  final List<Tag> associatedTagsList;

  NoteAdditions({
    this.associatedTagsList,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
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
                        builder: (context) => AlertDialogTags(
                          associatedTagsList: associatedTagsList,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
        child: Icon(
          Icons.more_vert,
          color: Colors.white70,
        ),
      ),
    );
  }
}