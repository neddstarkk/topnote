import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topnotes/data/models/folder_model.dart';
import 'package:topnotes/internal/constants.dart';
import 'package:topnotes/ui/screens/notes_list_screen.dart';

Widget buildFoldersList(List<Folder> listNew) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: listNew.length ,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(
          "${listNew[index].folderName}",
          style: TextStyle(color: Colors.white),
        ),
        leading: listNew[index].icon != null ? listNew[index].icon : Icon(
          Icons.folder_outlined,
          color: tileIconColor,
        ),
        trailing: Text("${listNew[index].notesUnderFolder.length}",
            style: tileTrailTextStyle),
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => NotesListScreen(
                screenTitle: listNew[index].folderName,
                notesToBeDisplayed: listNew[index].notesUnderFolder,
              ),
            ),
          );
        },
      );
    },
  );
}
