import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/folders/folder_cubit.dart';
import 'package:topnotes/data/models/folder_model.dart';
import 'package:topnotes/data/models/notes_model.dart';
import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/internal/constants.dart';
import 'package:topnotes/internal/size_config.dart';
import 'package:topnotes/ui/widgets/note_page_widgets/associated_tags_widget.dart';
import 'package:topnotes/ui/widgets/note_page_widgets/content_textfield.dart';
import 'package:topnotes/ui/widgets/note_page_widgets/note_additions.dart';
import 'package:topnotes/ui/widgets/note_page_widgets/note_taking_mechanisms.dart';

class NotePage extends StatefulWidget {
  Note note;

  NotePage({this.note});

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  List<Tag> associatedTagsList = [];
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.note != null) {
      titleController.text = widget.note.title;
    }
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
            TextField(
              cursorColor: Colors.white,
              controller: titleController,
              textCapitalization: TextCapitalization.sentences,
              style: noteTitleTextStyle.copyWith(
                fontSize: SizeConfig.blockSizeVertical * 2,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: "Title",
                hintStyle: noteTitleTextStyle.copyWith(
                    fontSize: SizeConfig.blockSizeVertical * 2),
                border: InputBorder.none,
              ),
              onChanged: (text) {
                // if this is a new note and a change has just been made.
                if (titleController.text.length == 1 && widget.note == null) {
                  // TODO: Assign a nodeID, update title, associate folder general,
                  var time = DateTime.now();
                  var newNote = Note(
                    noteId: time.toString(),
                    title: text,
                    associatedFolder: 'General',
                    associatedTags: [],
                    isFavorite: false,
                    content: '',
                    timeStamp: time,
                  );

                  widget.note = newNote;

                  BlocProvider.of<FolderCubit>(context).addNoteToFolder('General', newNote);
                }
                // a note object exists
                else {
                  widget.note.title = text;

                  BlocProvider.of<FolderCubit>(context).updateNote('General', widget.note);
                }
              },
            ),

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
                // this container will contain different types of
                // note taking mechanisms like lists, images from gallery etc
                NoteTakingMechanisms(),

                // this container will allow user to toggle the bottomsheet that
                // provides further options to add tags and add note to folder.
                NoteAdditions(
                  associatedTagsList: associatedTagsList,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
