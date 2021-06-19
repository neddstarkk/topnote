import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topnotes/data/models/folder_model.dart';
import 'package:topnotes/internal/constants.dart';
import 'package:topnotes/ui/screens/notes_list_screen.dart';

class FoldersList extends StatelessWidget {
  final List<Folder> _folders;

  const FoldersList(this._folders, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _folders.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            "${_folders[index].folderName}",
            style: TextStyle(color: Colors.white),
          ),
          leading: _folders[index].icon != null
              ? _folders[index].icon
              : Icon(
                  Icons.folder_outlined,
                  color: tileIconColor,
                ),
          trailing: Text("${_folders[index].notesUnderFolder.length}",
              style: tileTrailTextStyle),
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => NotesListScreen(
                  screenTitle: _folders[index].folderName,
                  notesToBeDisplayed: _folders[index].notesUnderFolder,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
