import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/tags/tag_cubit.dart';
import 'package:topnotes/data/models/notes_model.dart';
import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/internal/size_config.dart';
import 'package:topnotes/ui/widgets/note_page_widgets/alert_dialog_folders.dart';

import 'alert_dialog_tags.dart';

class NoteOperations extends StatefulWidget {
  final Note note;

  NoteOperations({
    this.note,
    Key key,
  }) : super(key: key);

  @override
  _NoteOperationsState createState() => _NoteOperationsState();
}

class _NoteOperationsState extends State<NoteOperations> {
  List<Tag> tags;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tags = BlocProvider.of<TagCubit>(context).getTagList();
  }

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
                    enabled: widget.note != null ? true : false,
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialogFolders(note: widget.note,),
                      );
                    },
                  ),
                  ListTile(
                    enabled:
                        tags.isNotEmpty && widget.note != null ? true : false,
                    leading: Icon(
                      Icons.local_offer_outlined,
                      color: Color(0xFF2F4E60),
                    ),
                    title: Text(
                      "Add tags",
                      style: TextStyle(color: Colors.white70),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialogTags(
                          note: widget.note,
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
