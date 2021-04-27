import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/tags/tag_cubit.dart';
import 'package:topnotes/data/models/tags_model.dart';

class AlertDialogTags extends StatefulWidget {
  final List<Tag> associatedTagsList;

  AlertDialogTags({this.associatedTagsList});

  @override
  _AlertDialogTagsState createState() => _AlertDialogTagsState();
}

class _AlertDialogTagsState extends State<AlertDialogTags> {
  @override
  Widget build(BuildContext context) {
    var state = context.bloc<TagCubit>().getTagList();

    return AlertDialog(
      title: Text("Select Tags"),
      content: Container(
        width: 100,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: state.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text("${state[index].tagName}"),
                value: state[index].isSelected,
                onChanged: (newVal) {
                  setState(() {
                    state[index].isSelected = newVal;
                  });

                  if (state[index].isSelected == true &&
                      widget.associatedTagsList.indexOf(state[index]) == -1) {
                    widget.associatedTagsList.add(state[index]);

                  } else if (state[index].isSelected == false &&
                      widget.associatedTagsList.indexOf(state[index]) != -1) {
                    widget.associatedTagsList.remove(state[index]);
                  }
                },
              );
            }),
      ),
    );
  }
}
