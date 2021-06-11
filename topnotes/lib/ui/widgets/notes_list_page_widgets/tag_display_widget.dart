import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/folders/folder_cubit.dart';
import 'package:topnotes/cubits/tags/tag_cubit.dart';
import 'package:topnotes/data/models/notes_model.dart';
import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/internal/size_config.dart';

class TagDisplayWidget extends StatelessWidget {
  TagDisplayWidget({
    @required this.tag,
    this.note,
  });

  final Tag tag;
  final Note note;

  @override
  Widget build(BuildContext context) {
    var tagList = BlocProvider.of<TagCubit>(context).tagList;

    if (tagList.contains(tag)) {
      return Container(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
        decoration: BoxDecoration(
          color: Color(0xFF687581),
          borderRadius: BorderRadius.circular(
            SizeConfig.blockSizeVertical * 10,
          ),
        ),
        child: Text(
          "#${tag.tagName}",
          style: TextStyle(color: Colors.white70),
        ),
      );
    } else {
      BlocProvider.of<FolderCubit>(context).removeTagFromNote(tag, note);
    }

    return Text("");
  }
}
