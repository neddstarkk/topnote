import 'package:flutter/material.dart';
import 'package:topnotes/utils/constants.dart';
import 'package:topnotes/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List folderList = [1, 2, 3, 4, 5, 6, 7, 8];

  List tagsList = [1, 2, 3, 4, 5, 6, 7, 8];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
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
              child: Text(
                "TopNotes",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical * 4,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
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
                    "All notes",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.folder,
                    color: tileIconColor,
                  ),
                  trailing: Text("$index", style: tileTrailTextStyle),
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

            for (var i in tagsList)
              ListTile(
                leading: Icon(Icons.local_offer_outlined, color: tileIconColor,),
                title: Text(
                  "Tag number $i",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Text("$i", style: tileTrailTextStyle,),
              ),
          ],
        ),
      ),
    );
  }
}
