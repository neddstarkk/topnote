import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/data/models/folder_model.dart';

import 'package:topnotes/internal/utils.dart';
import 'package:topnotes/internal/constants.dart';
import 'package:topnotes/internal/size_config.dart';

import 'package:topnotes/ui/screens/note_page.dart';
import 'package:topnotes/ui/widgets/home_screen_widgets/custom_fab.dart';
import 'package:topnotes/ui/widgets/home_screen_widgets/home_screen_body.dart';

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

  void onNewNote() async {
    var result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => NotePage(),
      ),
    );
    if (result == true) {
      setState(() {});
    }
  }

  void onTap() async {
    var result = await Navigator.push(
        context, CupertinoPageRoute(builder: (context) => NotePage()));
    if (result == true) {
      setState(() {});
    }
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
        onTap: () => Utils.addTag(context, controller),
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
        onTap: () => Utils.addFolder(context, controller),
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
        onTap: onNewNote,
      ),
    ];
  }

  AppBar get customAppBar {
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

    return deleteState ? newAppBar : defaultAppBar;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: customAppBar,
      floatingActionButton: CustomFloatingActionButton(
        onTap: onTap,
        scrollController: scrollController,
        fabOptions: fabOptions,
      ),
      body: GestureDetector(
        onTap: () {
          setState(() => selected = false);
        },
        child: HomeScreenBody(
          scrollController: scrollController,
          deleteState: deleteState,
          onLongPress: () => setState(() => deleteState = true),
        ),
      ),
    );
  }
}
