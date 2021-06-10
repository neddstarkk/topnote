import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/folders/folder_cubit.dart';
import 'package:topnotes/data/models/folder_model.dart';
import 'package:topnotes/internal/constants.dart';
import 'package:topnotes/ui/screens/notes_list_screen.dart';

class FoldersDisplay extends StatefulWidget {
  @override
  _FoldersDisplayState createState() => _FoldersDisplayState();
}

class _FoldersDisplayState extends State<FoldersDisplay> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FolderCubit, List<Folder>>(
      builder: (context, state) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                "${state[index].folderName}",
                style: textStyle,
              ),
              leading: state[index].icon != null
                  ? state[index].icon
                  : Icon(
                      Icons.folder_outlined,
                      color: iconColor,
                    ),
              trailing: Text(
                "${state[index].notesUnderFolder.length}",
                style: textStyle,
              ),
              onTap: () async {
                var result = await Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => NotesListScreen(
                      screenTitle: state[index].folderName,
                      notesToBeDisplayed: state[index].notesUnderFolder,
                    ),
                  ),
                );
                if (result == true) {
                  setState(() {});
                }
              },
            );
          },
        );
      },
    );
  }
}
