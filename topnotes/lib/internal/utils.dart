import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/folders/folder_cubit.dart';
import 'package:topnotes/cubits/tags/tag_cubit.dart';

void addFolder(BuildContext context, TextEditingController controller) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Folder"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter Folder Name"),
            textCapitalization: TextCapitalization.sentences,
          ),
          actions: [
            // ignore: deprecated_member_use
            TextButton(
              child: Text("ADD"),
              onPressed: () {
                final folderCubit = context.bloc<FolderCubit>();
                folderCubit.addNewFolder(controller.text);
                controller.clear();
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

void addTag(BuildContext context, TextEditingController controller) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Tag"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter Tag Name"),
          ),
          actions: [
            TextButton(
              child: Text("ADD"),
              onPressed: () {
                final tagCubit = context.bloc<TagCubit>();
                tagCubit.addNewTag(controller.text);
                controller.clear();
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
