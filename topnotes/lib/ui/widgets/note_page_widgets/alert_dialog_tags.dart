import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/tags/tag_cubit.dart';
import 'package:topnotes/data/models/notes_model.dart';

class AlertDialogTags extends StatefulWidget {
  final Note note;

  AlertDialogTags({this.note});

  @override
  _AlertDialogTagsState createState() => _AlertDialogTagsState();
}

class _AlertDialogTagsState extends State<AlertDialogTags> {

  @override
  Widget build(BuildContext context) {
    var listOfTags = context.read<TagCubit>().getTagList();

    return AlertDialog(
      title: Text("Select Tags"),
      content: Container(
        width: 100,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: listOfTags.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text("${listOfTags[index].tagName}"),
                value: listOfTags[index].isSelected,
                onChanged: (newVal) {
                  setState(() {
                    listOfTags[index].isSelected = newVal;
                  });

                  if (listOfTags[index].isSelected == true &&
                      widget.note.associatedTags.indexOf(listOfTags[index]) == -1) {
                    widget.note.associatedTags.add(listOfTags[index]);
                    BlocProvider.of<TagCubit>(context).addNoteUnderTag(listOfTags[index].tagName, widget.note);

                  } else if (listOfTags[index].isSelected == false &&
                      widget.note.associatedTags.indexOf(listOfTags[index]) != -1) {
                    widget.note.associatedTags.remove(listOfTags[index]);
                    BlocProvider.of<TagCubit>(context).removeNoteFromTag(listOfTags[index].tagName, widget.note);
                  }
                },
              );
            }),
      ),
    );
  }
}
