import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/folders/folder_cubit.dart';
import 'package:topnotes/cubits/tags/tag_cubit.dart';
import 'package:topnotes/data/models/folder_model.dart';
import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/internal/constants.dart';
import 'package:topnotes/internal/show_fab_menu.dart';
import 'package:topnotes/internal/size_config.dart';
import 'package:topnotes/ui/screens/note_page.dart';
import 'package:topnotes/ui/widgets/home_screen_widgets/fake_fab.dart';
import 'package:topnotes/ui/widgets/home_screen_widgets/folder_text.dart';
import 'package:topnotes/ui/widgets/home_screen_widgets/folders_display.dart';
import 'package:topnotes/ui/widgets/home_screen_widgets/tags_text.dart';

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
  bool deleteState = false;

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
              // ignore: deprecated_member_use
              TextButton(
                child: Text("ADD"),
                onPressed: () {
                  final folderCubit = context.read<FolderCubit>();
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
            ),
            actions: [
              TextButton(
                child: Text("ADD"),
                onPressed: () {
                  final tagCubit = context.read<TagCubit>();
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
          color: iconColor,
        ),
        title: Text(
          "New Tag",
          style: textStyle,
        ),
        onTap: () => addTag(context),
      ),
      ListTile(
        leading: Icon(
          Icons.folder_open_outlined,
          color: iconColor,
        ),
        title: Text(
          "New Folder",
          style: textStyle,
        ),
        onTap: () {
          addFolder(context);
        },
      ),
      ListTile(
        leading: Icon(
          Icons.add,
          color: iconColor,
        ),
        title: Text(
          "New Note",
          style: textStyle,
        ),
        onTap: () async {
          var result = await Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => NotePage(),
            ),
          );
          if (result == true) {
            setState(() {});
          }
        },
      ),
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
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(SizeConfig.blockSizeVertical * 10),
        ),
        onTap: () async {
          var result = await Navigator.push(
              context, CupertinoPageRoute(builder: (context) => NotePage()));
          if (result == true) {
            setState(() {});
          }
        },
        child: Icon(
          Icons.add,
          color: iconColor,
          size: SizeConfig.blockSizeVertical * 3,
        ),
      ),
    );
  }

  AppBar assignAppBar() {
    AppBar defaultAppBar = AppBar(
      toolbarHeight: SizeConfig.blockSizeVertical * 10,
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      title: Text(
        "TopNotes",
        style: TextStyle(
          fontSize: SizeConfig.blockSizeVertical * 4,
          color: AppColors.textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    AppBar newAppBar = AppBar(
      backgroundColor: AppColors.backgroundColor,
      toolbarHeight: SizeConfig.blockSizeVertical * 10,
      elevation: 0,
      title: Text("Delete Tags & Folders"),
      leading: IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          setState(() {
            deleteState = false;
          });
        },
      ),
    );

    if (deleteState == true) return newAppBar;

    return defaultAppBar;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return LayoutBuilder(
      builder: (_, constraints) {
        final width = constraints.biggest.width;
        return Scaffold(
          appBar: assignAppBar(),
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
                // Folders text padding
                FolderText(),

                // Folders Listview
                FoldersDisplay(),

                // Tags text padding
                TagsText(),

                // tags list view
                BlocBuilder<TagCubit, List<Tag>>(
                  builder: (context, state) {
                    return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: width < 450
                            ? 2
                            : width < 600
                                ? 3
                                : 5,
                        childAspectRatio: width < 350
                            ? 2.5
                            : width < 500
                                ? 2.0
                                : 2.5,
                      ),
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onLongPress: () {
                            print("Long pressed");
                            setState(() {
                              deleteState = true;
                            });
                          },
                          child: Chip(
                            avatar: Icon(Icons.tag),
                            label: Text("${state[index].tagName}"),
                            useDeleteButtonTooltip: false,
                            deleteIcon: deleteState == false
                                ? Text("${state[index].notesUnderTag.length}")
                                : Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                            onDeleted: () {
                              print("deleted");
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
