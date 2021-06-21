import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:topnotes/cubits/folders/folder_cubit.dart';

import 'package:topnotes/data/models/notes_model.dart';

import 'package:topnotes/internal/constants.dart';
import 'package:topnotes/internal/size_config.dart';

import 'package:topnotes/ui/widgets/note_page_widgets/associated_tags_widget.dart';
import 'package:topnotes/ui/widgets/note_page_widgets/custom_bottom_navbar.dart';

class NotePage extends StatefulWidget {
  final Note note;

  const NotePage({this.note});

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Note note;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    note = widget.note;
    if (note != null) {
      titleController.text = note.title;
      contentController.text = note.content;
    }
  }

  void toggleFavourite() {
    if (note != null) {
      setState(() {
        note.isFavorite = !note.isFavorite;
        BlocProvider.of<FolderCubit>(context).favoriteNote(note);
      });
    }
  }

  void onTitleChange(title) {
    // if this is a new note and a change has just been made.
    if (titleController.text.length > 0 && note == null) {
      note = Note(title: title);

      BlocProvider.of<FolderCubit>(context)
          .addNoteToFolder(note.associatedFolders[0].folderName, note);
    } else {
      // a note object exists
      note.title = title;
      BlocProvider.of<FolderCubit>(context).updateNote(note);
    }

    if (note != null &&
        contentController.text.length == 0 &&
        titleController.text.length == 0) {
      for (var i = 0; i < note.associatedFolders.length; i++) {
        BlocProvider.of<FolderCubit>(context)
            .removeNoteFromFolder(note.associatedFolders[i].folderName, note);
      }
    }
  }

  void onContentChange(content) {
    RegExp lineBreaks = RegExp("[\\n\\r]+");
    if (note == null &&
        contentController.text.length > 0 &&
        !lineBreaks.hasMatch(content)) {
      note = Note(content: content);

      BlocProvider.of<FolderCubit>(context)
          .addNoteToFolder(note.associatedFolders[0].folderName, note);
    } else if (note != null) {
      note.content = content;
      BlocProvider.of<FolderCubit>(context).updateNote(note);
    }

    if (note != null &&
        contentController.text.length == 0 &&
        titleController.text.length == 0) {
      for (var i = 0; i < note.associatedFolders.length; i++) {
        BlocProvider.of<FolderCubit>(context).removeNoteFromFolder(
          note.associatedFolders[i].folderName,
          note,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          leading: BackButton(
            color: iconColor,
            onPressed: () => Navigator.pop(context, true),
          ),
          actions: [
            Padding(
              padding:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
              child: IconButton(
                icon: note != null && note.isFavorite
                    ? Icon(
                        Icons.star,
                        color: Colors.amber,
                      )
                    : Icon(
                        Icons.star_border_outlined,
                      ),
                onPressed: toggleFavourite,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // title textfield
                TextField(
                  cursorColor: Colors.white,
                  controller: titleController,
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical * 2,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle:
                        TextStyle(fontSize: SizeConfig.blockSizeVertical * 2),
                    border: InputBorder.none,
                  ),
                  onChanged: onTitleChange,
                ),

                // associated tags Container

                Container(
                  child: Row(
                    children: [
                      if (note != null && note.associatedTags.isNotEmpty)
                        for (var tag in note.associatedTags)
                          AssociatedTags(tag),
                    ],
                  ),
                ),

                // content textfield,
                TextField(
                  controller: contentController,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical * 2,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Content",
                    hintStyle: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 2,
                    ),
                  ),
                  onChanged: onContentChange,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(note: note),
      ),
    );
  }
}
