import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/folders/folder_cubit.dart';
import 'package:topnotes/data/models/folder_model.dart';
import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/ui/widgets/build_folders_list_widget.dart';
import 'package:topnotes/ui/widgets/build_tags_list_widget.dart';
import 'package:topnotes/ui/widgets/custom_appbar_row.dart';
import 'package:topnotes/ui/widgets/custom_fab.dart';
import 'package:topnotes/utils/constants.dart';
import 'package:topnotes/utils/size_config.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Folder> folderList = [];

  List<Tag> tagsList = [
    Tag(tagName: "insta", notesUnderTag: [1, 2, 3, 4]),
    Tag(tagName: "work", notesUnderTag: [1, 2, 3, 4, 5]),
    Tag(tagName: "design", notesUnderTag: [1, 2]),
  ];

  TextEditingController controller = TextEditingController();
  bool selected = false;

  void onFABPress(BuildContext context) {
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
              FlatButton(
                child: Text("ADD"),
                onPressed: () {
                  final folderCubit = context.bloc<FolderCubit>();
                  folderCubit.changeState(controller.text);
                  controller.clear();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      floatingActionButton: GestureDetector(
        onLongPress: () {
          if (selected == false) {
            setState(() {
              selected = !selected;
              HapticFeedback.lightImpact();
            });
          }
        },
        onTap: () {
          if (selected == false) {
            onFABPress(context);
          }
        },
        child: CustomFAB(selected: selected),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            selected = false;
          });
        },
        child: ListView(
          primary: true,
          physics: BouncingScrollPhysics(),
          children: [
            // TopNotes text padding
            Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 4,
                  left: SizeConfig.blockSizeHorizontal * 4,
                  bottom: SizeConfig.blockSizeVertical * 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TopNotes",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 4,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CustomAppBarRow(),
                  ),
                ],
              ),
            ),

            // Folders text padding
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 4,
                  bottom: SizeConfig.blockSizeVertical * 2),
              child: Text(
                "Folders",
                style: tagTextStyle.copyWith(
                    fontSize: SizeConfig.blockSizeVertical * 2),
              ),
            ),

            // Folders Listview
            BlocBuilder<FolderCubit, List<Folder>>(
              builder: (context, state) {
                return buildFoldersList(state);
              },
            ),

            // Tags text padding
            Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 2,
                  left: SizeConfig.blockSizeHorizontal * 4,
                  bottom: SizeConfig.blockSizeVertical * 2),
              child: Text(
                "Tags",
                style: tagTextStyle.copyWith(
                    fontSize: SizeConfig.blockSizeVertical * 2),
              ),
            ),

            // tags list view
            for (Tag tag in tagsList)
              buildTagsList(tag),
          ],
        ),
      ),
    );
  }


}


