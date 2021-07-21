import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/folders/folder_cubit.dart';
import 'package:topnotes/data/models/notes_model.dart';
import 'package:topnotes/internal/constants.dart';
import 'package:topnotes/internal/size_config.dart';
import 'package:topnotes/internal/utils.dart';
import 'package:topnotes/ui/screens/note_page.dart';
import 'package:topnotes/ui/widgets/home_screen_widgets/custom_appbar_row.dart';
import 'package:topnotes/ui/widgets/notes_list_page_widgets/empty_state_widget.dart';
import 'package:topnotes/ui/widgets/notes_list_page_widgets/tag_display_widget.dart';

class NotesListScreen extends StatefulWidget {
  final String screenTitle;
  List<Note> notesToBeDisplayed;

  NotesListScreen(
      {@required this.notesToBeDisplayed, @required this.screenTitle});

  @override
  _NotesListScreenState createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  var tapPosition;
  Color tileColor = Colors.white10;
  bool triggerGlobalSelection = false;
  List<int> selectedList = [];

  AppBar assignAppbar() {
    AppBar defaultAppBar = AppBar(
      toolbarHeight: SizeConfig.blockSizeVertical * 8,
      title: Text(
        "${widget.screenTitle}",
        style: TextStyle(
            fontSize: SizeConfig.blockSizeVertical * 4,
            color: AppColors.textColor),
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: AppColors.backgroundColor,
      actions: [
        widget.screenTitle == "Trash" && widget.notesToBeDisplayed.isNotEmpty
            ? PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 0,
                      child: IconTextWidget(
                        icon: Icon(Icons.delete_forever),
                        text: "Empty Trash",
                      ),
                    )
                  ];
                },
                onSelected: (value) {
                  if (value == 0) {
                    setState(() {
                      BlocProvider.of<FolderCubit>(context)
                          .emptyFolder("Trash");
                      widget.notesToBeDisplayed = [];
                    });
                  }
                },
              )
            : Text(""),
      ],
    );

    AppBar newAppBar = AppBar(
      toolbarHeight: SizeConfig.blockSizeVertical * 8,
      backgroundColor: AppColors.backgroundColor,
      leading: IconButton(
        onPressed: () {
          setState(() {
            selectedList = [];
            triggerGlobalSelection = false;
          });
        },
        icon: Icon(
          Icons.clear,
          size: SizeConfig.blockSizeVertical * 3,
          color: iconColor,
        ),
      ),
      title: Text(
        "${selectedList.length}",
        style: TextStyle(color: AppColors.textColor),
      ),
      actions: [
        widget.screenTitle == "Trash"
            ? Padding(
                padding: EdgeInsets.only(right: 10),
                child: TextButton.icon(
                    onPressed: () {
                      for (var i in selectedList) {
                        BlocProvider.of<FolderCubit>(context).addNoteToFolder(
                            'All Notes', widget.notesToBeDisplayed[i]);
                        BlocProvider.of<FolderCubit>(context)
                            .removeNoteFromFolder(
                                'Trash', widget.notesToBeDisplayed[i]);
                      }
                      setState(() {
                        selectedList = [];
                        triggerGlobalSelection = false;
                      });
                    },
                    icon: Icon(Icons.restore),
                    label: Text("Restore"),
                    style: appBarContextButtonStyle),
              )
            : Padding(
                padding: EdgeInsets.only(right: 10),
                child: TextButton.icon(
                  onPressed: () {
                    if (widget.screenTitle != "Trash") {
                      for (var note in selectedList) {
                        BlocProvider.of<FolderCubit>(context)
                            .moveNoteToTrash(widget.notesToBeDisplayed[note]);
                      }
                      setState(() {
                        selectedList = [];
                        triggerGlobalSelection = false;
                      });
                    }
                  },
                  icon: Icon(Icons.delete),
                  label: Text("Delete"),
                  style: appBarContextButtonStyle,
                ),
              ),
        widget.screenTitle == "Trash"
            ? PopupMenuButton(
                onSelected: (value) {
                  if (value == 0) {
                    for (var i in selectedList) {
                      BlocProvider.of<FolderCubit>(context)
                          .removeNoteFromFolder(
                              "Trash", widget.notesToBeDisplayed[i]);
                    }
                    setState(() {
                      selectedList = [];
                      triggerGlobalSelection = false;
                    });
                  }
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        value: 0,
                        child: IconTextWidget(
                          icon: Icon(Icons.delete),
                          text: "Delete",
                        ))
                  ];
                },
              )
            : Text(""),
      ],
    );
    if (triggerGlobalSelection == true) {
      return newAppBar;
    }
    return defaultAppBar;
  }

  void displaySelectOptions() {
    showDialog(context: context, builder: (context) => Container());
  }

  void _storePosition(TapDownDetails details) {
    tapPosition = details.globalPosition;
  }

  Future<bool> nativeBackButtonControl() {
    if (triggerGlobalSelection == true) {
      setState(() {
        selectedList = [];
        triggerGlobalSelection = false;
      });
    } else if (triggerGlobalSelection == false && 1 == 1) {
      Navigator.pop(context, true);
      return Future.value(true);
    }
    return Future.value(false);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: nativeBackButtonControl,
      child: Scaffold(
        appBar: assignAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 4,
            ),
            child: widget.notesToBeDisplayed.length == 0
                ? EmptyStateWidget()
                : LayoutBuilder(
                    builder: (_, constraints) {
                      final width = constraints.biggest.width;
                      return ListView.builder(
                        reverse: true,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.notesToBeDisplayed.length,
                        itemBuilder: (context, index) => Material(
                          color: Colors.transparent,
                          child: InkWell(
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
                                color: Colors.white10,
                                border: Border.all(
                                    color: selectedList.contains(index) == true
                                        ? Color(0xFFD8D8D8)
                                        : Colors.transparent),
                                borderRadius: BorderRadius.circular(
                                  SizeConfig.blockSizeHorizontal,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      "${widget.notesToBeDisplayed[index].title}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white70,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${NoteTileDisplay.displayTime(
                                          widget.notesToBeDisplayed[index]
                                              .timeStamp,
                                        )}",
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(color: Colors.white38),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3),
                                          child: Container(
                                            child: Text(
                                              "${NoteTileDisplay.displayContent(widget.notesToBeDisplayed[index].content)}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: Colors.white60,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.blockSizeVertical * 2,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 69,
                                        height: 25,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: Utils.tagDisplayLength(
                                            width,
                                            widget.notesToBeDisplayed[index]
                                                .associatedTags,
                                          ),
                                          itemBuilder: (context, i) =>
                                              TagDisplayWidget(
                                            tag: widget
                                                .notesToBeDisplayed[index]
                                                .associatedTags[i],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      SizedBox(
                                        width: 5,
                                      ),
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
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
