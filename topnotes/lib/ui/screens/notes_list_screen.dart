import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topnotes/data/models/notes_model.dart';
import 'package:topnotes/internal/constants.dart';
import 'package:topnotes/internal/size_config.dart';
import 'package:topnotes/ui/screens/note_page.dart';
import 'package:topnotes/ui/widgets/notes_list_page_widgets/empty_state_widget.dart';

class NotesListScreen extends StatefulWidget {
  final String screenTitle;
  final List<Note> notesToBeDisplayed;

  NotesListScreen(
      {@required this.notesToBeDisplayed, @required this.screenTitle});

  @override
  _NotesListScreenState createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  bool gridCountTwo = false;
  var tapPosition;
  Color tileColor = Colors.white10;
  bool triggerGlobalSelection = false;
  List<int> selectedList = [];

  AppBar assignAppbar() {
    AppBar defaultAppBar = AppBar(
      toolbarHeight: SizeConfig.blockSizeVertical * 10,
      title: Text(
        "${widget.screenTitle}",
        style: TextStyle(
          fontSize: SizeConfig.blockSizeVertical * 4,
        ),
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Color(0xFF0C1720),
    );

    AppBar newAppBar = AppBar();

    if (triggerGlobalSelection == true) {
      return newAppBar;
    }

    return defaultAppBar;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _storePosition(TapDownDetails details) {
    tapPosition = details.globalPosition;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (1 == 1) {
          Navigator.pop(context, true);
        }

        return Future.value(true);
      },
      child: Scaffold(
        appBar: assignAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 4),
            child: widget.notesToBeDisplayed.length == 0
                ? EmptyStateWidget()
                : GridView.builder(
                    reverse: true,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.notesToBeDisplayed.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: SizeConfig.blockSizeVertical * 2,
                      crossAxisSpacing: SizeConfig.blockSizeHorizontal * 2,
                      childAspectRatio: 3.0,
                    ),
                    itemBuilder: (context, index) => GestureDetector(
                      onTapDown: _storePosition,
                      onLongPress: () {
                        if (triggerGlobalSelection == false) {
                          setState(() {
                            triggerGlobalSelection = true;
                            selectedList.add(index);
                          });
                        }
                      },
                      onTap: () async {
                        if (triggerGlobalSelection == false) {
                          var result = await Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => NotePage(
                                note: widget.notesToBeDisplayed[index],
                              ),
                            ),
                          );
                          if (result == true) {
                            setState(() {});
                          }
                        } else if (triggerGlobalSelection == true) {
                          if (selectedList.contains(index)) {
                            setState(() {
                              selectedList.remove(index);
                            });

                            if (selectedList.isEmpty) {
                              setState(() {
                                triggerGlobalSelection = false;
                              });
                            }
                          } else {
                            setState(() {
                              selectedList.add(index);
                            });
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedList.contains(index) == true
                              ? Colors.white70
                              : Colors.white10,
                          borderRadius: BorderRadius.circular(
                              SizeConfig.blockSizeHorizontal),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 5,
                          vertical: SizeConfig.blockSizeVertical * 2.5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.blockSizeHorizontal),
                              child: Container(
                                child: Text(
                                  "${widget.notesToBeDisplayed[index].title}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.blockSizeVertical * 2,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${NoteTileDisplay.displayTime(
                                    widget.notesToBeDisplayed[index].timeStamp,
                                  )}",
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(color: Colors.white38),
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 3),
                                  child: Container(
                                    child: Text(
                                      "${NoteTileDisplay.displayContent(widget.notesToBeDisplayed[index].content)}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.white60),
                                    ),
                                  ),
                                )),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 2,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (var tag in widget
                                        .notesToBeDisplayed[index]
                                        .associatedTags)
                                      Container(
                                        padding: EdgeInsets.all(
                                            SizeConfig.blockSizeHorizontal),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF687581),
                                          borderRadius: BorderRadius.circular(
                                            SizeConfig.blockSizeVertical * 10,
                                          ),
                                        ),
                                        child: Text(
                                          "#${tag.tagName}",
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                      ),
                                    Spacer(),
                                    Icon(
                                      Icons.star,
                                      color: widget.notesToBeDisplayed[index]
                                                  .isFavorite ==
                                              true
                                          ? Colors.amber
                                          : Colors.white10,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
