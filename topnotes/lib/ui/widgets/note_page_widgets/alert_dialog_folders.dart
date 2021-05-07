import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/folders/folder_cubit.dart';
import 'package:topnotes/data/models/folder_model.dart';
import 'package:topnotes/data/models/notes_model.dart';
import 'package:toast/toast.dart';

class AlertDialogFolders extends StatefulWidget {
  final Note note;

  AlertDialogFolders({this.note});

  @override
  _AlertDialogFoldersState createState() => _AlertDialogFoldersState();
}

class _AlertDialogFoldersState extends State<AlertDialogFolders> {
  List<Folder> fetchedFolders;
  int value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchedFolders =
        List<Folder>.from(BlocProvider.of<FolderCubit>(context).folders);
    fetchedFolders.removeWhere((element) => element.typeOfFolder != "UC");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select Folder"),
      content: Container(
        width: 100,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: fetchedFolders.length,
          itemBuilder: (context, index) => RadioListTile(
            value: index,
            groupValue: value,
            onChanged: (ind) {
              setState(() {
                value = ind;
              });
            },
            title: Text("${fetchedFolders[index].folderName}"),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text("ADD"),
          onPressed: () {
            if (value != null &&
                BlocProvider.of<FolderCubit>(context).checkNoteInFolder(
                        '${fetchedFolders[value].folderName}', widget.note) ==
                    false) {
              BlocProvider.of<FolderCubit>(context).addNoteToFolder(
                  '${fetchedFolders[value].folderName}', widget.note);

              Toast.show(
                "Added to folder",
                context,
                duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM,
                backgroundColor: Colors.grey.shade800,
              );
              Future.delayed(Duration(milliseconds: 1200), () {
                Navigator.pop(context);
              });
            } else if (BlocProvider.of<FolderCubit>(context).checkNoteInFolder(
                    '${fetchedFolders[value].folderName}', widget.note) ==
                true) {
              Toast.show("Already present in folder", context,
                  duration: Toast.LENGTH_SHORT,
                  gravity: Toast.BOTTOM,
                  backgroundColor: Colors.grey.shade800);
            }
          },
        )
      ],
    );
  }
}
