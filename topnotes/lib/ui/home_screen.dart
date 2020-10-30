import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topnotes/models/folder_model.dart';
import 'package:topnotes/models/tags_model.dart';
import 'package:topnotes/ui/widgets/custom_fab.dart';
import 'package:topnotes/utils/constants.dart';
import 'package:topnotes/utils/size_config.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Folder> folderList = [
    Folder(
        folderName: "All notes",
        typeOfFolder: "Normal",
        notesUnderFolder: [1, 2]),
    Folder(
        folderName: "General",
        typeOfFolder: "Normal",
        notesUnderFolder: [1, 3]),
  ];

  List<Tag> tagsList = [
    Tag(tagName: "insta", notesUnderTag: [1, 2, 3, 4]),
    Tag(tagName: "work", notesUnderTag: [1, 2, 3, 4, 5]),
    Tag(tagName: "design", notesUnderTag: [1, 2]),
  ];

  TextEditingController controller = TextEditingController();
  bool selected = false;

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
          if (selected == true) {
            setState(() {
              selected = !selected;
            });
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
                    onTap: () {
                      print("Settings button pressed");
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: tileIconColor,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              right: SizeConfig.blockSizeHorizontal * 4,
                              left: SizeConfig.blockSizeHorizontal,
                            ),
                            child: Text(
                              "Settings",
                              style: TextStyle(color: tileIconColor),
                            ),
                          )
                        ],
                      ),
                    ),
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
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: folderList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    "${folderList[index].folderName}",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.folder,
                    color: tileIconColor,
                  ),
                  trailing: Text("${folderList[index].notesUnderFolder.length}",
                      style: tileTrailTextStyle),
                );
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

            for (var tag in tagsList)
              ListTile(
                leading: Icon(
                  Icons.local_offer_outlined,
                  color: tileIconColor,
                ),
                title: Text(
                  "${tag.tagName}",
                  style: TextStyle(color: Color(0xFF667079)),
                ),
                trailing: Text(
                  "${tag.notesUnderTag.length}",
                  style: tileTrailTextStyle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}


