import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/folders/folder_cubit.dart';
import 'package:topnotes/cubits/tags/tag_cubit.dart';
import 'package:topnotes/data/models/folder_model.dart';
import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/internal/utils/constants.dart';
import 'package:topnotes/internal/utils/global_key_registry.dart';
import 'package:topnotes/internal/utils/show_fab_menu.dart';
import 'package:topnotes/internal/utils/size_config.dart';
import 'package:topnotes/ui/widgets/build_folders_list_widget.dart';
import 'package:topnotes/ui/widgets/build_tags_list_widget.dart';
import 'package:topnotes/ui/widgets/custom_appbar_row.dart';
import 'package:topnotes/ui/widgets/fake_fab.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Folder> folderList = [];

  List<Tag> tagsList = [];

  TextEditingController controller = TextEditingController();
  ScrollController scrollController =
  ScrollController(initialScrollOffset: 0.0);
  bool selected = false;

  void addFolder(BuildContext context) {
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
                  folderCubit.addNewFolder(controller.text);
                  controller.clear();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void addTag(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add Tag"),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(hintText: "Enter Tag Name"),
              textCapitalization: TextCapitalization.sentences,
            ),
            actions: [
              FlatButton(
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


  List<Widget> get fabOptions {
    return [
      ListTile(
        leading: Icon(
          Icons.local_offer_outlined,
          color: Color(0xFF2F4E60),
        ),
        title: Text(
          "New Tag",
          style: TextStyle(color: Colors.white70),
        ),
        onTap: () => addTag(context),
      ),
      ListTile(
        leading: Icon(
          Icons.folder,
          color: Color(0xFF2F4E60),
        ),
        title: Text(
          "New Folder",
          style: TextStyle(color: Colors.white70),
        ),
        onTap: () {
          addFolder(context);
        },
      ),
      ListTile(
        leading: Icon(
          Icons.add,
          color: Color(0xFFDAC279),
        ),
        title: Text(
          "New Note",
          style: TextStyle(color: Colors.white70),
        ),
      )
    ];
  }

  Widget get fab {
    return Hero(
      tag: "fabMenu",
      child: FakeFab(
        controller: scrollController,
        onLongPress: () {
          Utils.showFabMenu(context, fabOptions);
        },
        key: GlobalKeyRegistry.get("fab"),
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(SizeConfig.blockSizeVertical * 10),
        ),
        onTap: () => addFolder(context),
        child: Icon(
          Icons.create,
          color: Color(0xFFDAC279),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      floatingActionButton: fab,
      body: GestureDetector(
        onTap: () {
          setState(() {
            selected = false;
          });
        },
        child: ListView(
          controller: scrollController,
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
            BlocBuilder<TagCubit, List<Tag>>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for(var tag in state) buildTagsList(tag),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
