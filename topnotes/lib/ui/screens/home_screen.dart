import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/folders/folder_cubit.dart';
import 'package:topnotes/cubits/tags/tag_cubit.dart';
import 'package:topnotes/data/models/folder_model.dart';
import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/internal/size_config.dart';
import 'package:topnotes/internal/utils.dart';
import 'package:topnotes/ui/screens/note_page.dart';
import 'package:topnotes/ui/widgets/home_screen_widgets/custom_fab.dart';
import 'package:topnotes/ui/widgets/home_screen_widgets/folders_list_widget.dart';
import 'package:topnotes/ui/widgets/home_screen_widgets/tags_list_widget.dart';
import 'package:topnotes/ui/widgets/home_screen_widgets/folder_text.dart';
import 'package:topnotes/ui/widgets/home_screen_widgets/tags_text.dart';
import 'package:topnotes/ui/widgets/home_screen_widgets/topnotes_text.dart';

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
        onTap: () => addTag(context, controller),
      ),
      ListTile(
        leading: Icon(
          Icons.folder_open_outlined,
          color: Color(0xFF2F4E60),
        ),
        title: Text(
          "New Folder",
          style: TextStyle(color: Colors.white70),
        ),
        onTap: () => addFolder(context, controller),
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
        onTap: () async {
          var result = await Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => NotePage(),
            ),
          );
          if (result == true) {
            setState(() {});
          }
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton:
          CustomFloatingActionButton(setState, scrollController, fabOptions),
      body: GestureDetector(
        onTap: () {
          setState(() => selected = false);
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
              builder: (context, folders) {
                return FoldersList(folders);
              },
            ),

            // Tags text padding
            TagsText(),

            // tags list view
            BlocBuilder<TagCubit, List<Tag>>(
              builder: (context, tags) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var tag in tags) TagsList(tag),
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
