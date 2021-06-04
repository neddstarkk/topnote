import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/folders/folder_cubit.dart';
import 'package:topnotes/cubits/tags/tag_cubit.dart';
import 'package:topnotes/data/models/folder_model.dart';
import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/internal/global_key_registry.dart';
import 'package:topnotes/internal/show_fab_menu.dart';
import 'package:topnotes/internal/size_config.dart';
import 'package:topnotes/ui/screens/note_page.dart';
import 'package:topnotes/ui/widgets/home_screen_widgets/fake_fab.dart';
import 'package:topnotes/ui/widgets/home_screen_widgets/folder_text.dart';
import 'package:topnotes/ui/widgets/home_screen_widgets/tags_text.dart';
import 'package:topnotes/ui/widgets/home_screen_widgets/topnotes_text.dart';

import 'notes_list_screen.dart';

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
        ),
        title: Text(
          "New Tag",
        ),
        onTap: () => addTag(context),
      ),
      ListTile(
        leading: Icon(
          Icons.folder_open_outlined,
        ),
        title: Text(
          "New Folder",
        ),
        onTap: () {
          addFolder(context);
        },
      ),
      ListTile(
        leading: Icon(
          Icons.add,
        ),
        title: Text(
          "New Note",
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
        key: GlobalKeyRegistry.get("fab"),
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
            TopnotesText(),

            // Folders text padding
            FolderText(),

            // Folders Listview
            BlocBuilder<FolderCubit, List<Folder>>(
              builder: (context, state) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        "${state[index].folderName}",
                      ),
                      leading: state[index].icon != null
                          ? state[index].icon
                          : Icon(
                              Icons.folder_outlined,
                            ),
                      trailing: Text(
                        "${state[index].notesUnderFolder.length}",
                      ),
                      onTap: () async {
                        var result = await Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => NotesListScreen(
                              screenTitle: state[index].folderName,
                              notesToBeDisplayed: state[index].notesUnderFolder,
                            ),
                          ),
                        );
                        if (result == true) {
                          setState(() {});
                        }
                      },
                    );
                  },
                );
              },
            ),

            // Tags text padding
            TagsText(),

            // tags list view
            BlocBuilder<TagCubit, List<Tag>>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var tag in state)
                      ListTile(
                        leading: Icon(
                          Icons.local_offer_outlined,
                        ),
                        title: Text(
                          "${tag.tagName}",
                        ),
                        trailing: Text(
                          "${tag.notesUnderTag.length}",
                        ),
                      ),
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
