import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/tags/tag_cubit.dart';
import 'package:topnotes/data/models/tags_model.dart';

class AlertDialogTags extends StatefulWidget {

  @override
  _AlertDialogTagsState createState() => _AlertDialogTagsState();
}

class _AlertDialogTagsState extends State<AlertDialogTags> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select Tags"),
      content: BlocBuilder<TagCubit, List<Tag>>(builder: (context, state) {
        return Container(
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
                      state[index].isSelected = !state[index].isSelected;
                      if(state[index].isSelected == true) {

                      }
                    });
                  },
                );
              }),
        );
      }),
      actions: [
        FlatButton(
          child: Text("ADD"),
          onPressed: () {
            final tagCubit = context.bloc<TagCubit>();
          },
        )
      ],
    );
  }
}
