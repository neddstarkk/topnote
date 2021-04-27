import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/tags/tag_cubit.dart';

class AlertDialogTags extends StatefulWidget {
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

                    if (state[index].isSelected == true &&
                        associatedTagsList.indexOf(state[index]) == -1) {
                      associatedTagsList.add(state[index]);
                    } else if (state[index].isSelected == false &&
                        associatedTagsList.indexOf(state[index]) != -1) {
                      associatedTagsList.remove(state[index]);
                    }
                  });
                },
              );
            }),
      ),
    );
  }
}
