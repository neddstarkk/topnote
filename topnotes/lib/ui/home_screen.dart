import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topnotes/models/folder_model.dart';
import 'package:topnotes/models/tags_model.dart';
import 'package:topnotes/utils/constants.dart';
import 'package:topnotes/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Folder> folderList = [
    Folder(folderName: "All notes", typeOfFolder: "Normal", notes: [1, 2]),
    Folder(folderName: "General", typeOfFolder: "Normal", notes: [1, 3]),
  ];

  List<Tag> tagsList = [
    Tag(tagName: "insta", notesUnderTag: [1, 2, 3, 4]),
    Tag(tagName: "work", notesUnderTag: [1, 2, 3, 4, 5]),
    Tag(tagName: "design", notesUnderTag: [1, 2]),
  ];

  TextEditingController controller = TextEditingController();

  void addFolder() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Folder"),
          content: TextField(
            controller: controller,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: "Enter folder name",
            ),
          ),
          actions: [
            FlatButton(
              child: Text("ADD"),
              onPressed: () {
                setState(
                  () {
                    folderList.add(
                      Folder(
                        folderName: "${controller.text}",
                        typeOfFolder: "Normal",
                        notes: [],
                      ),
                    );
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Color(0xFF132533),
          size: SizeConfig.blockSizeVertical * 3,
        ),
        backgroundColor: Color(0xFF928658),
        onPressed: () {
          addFolder();
        },
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        decoration: backgroundDecoration,
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
                  trailing: Text("${folderList[index].notes.length}",
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
