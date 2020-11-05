import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topnotes/data/models/folder_model.dart';
import 'package:topnotes/internal/constants.dart';
import 'package:topnotes/ui/screens/new_note.dart';

Widget buildFoldersList(List<Folder> listNew) {
  List<Folder> newList = listNew;
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: newList.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(
          "${newList[index].folderName}",
          style: TextStyle(color: Colors.white),
        ),
        leading: Icon(
          Icons.folder,
          color: tileIconColor,
        ),
        trailing: Text("${newList[index].notesUnderFolder.length}",
            style: tileTrailTextStyle),
        onTap: () {
          // TODO: Implement folder view
        },
      );
    },
  );
}
