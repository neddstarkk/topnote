import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/folders/folder_cubit.dart';
import 'package:topnotes/data/models/notes_model.dart';
import 'package:topnotes/internal/constants.dart';
import 'package:topnotes/internal/size_config.dart';
import 'package:topnotes/ui/screens/note_page.dart';
import 'package:topnotes/ui/widgets/notes_list_page_widgets/empty_state_widget.dart';
import 'package:topnotes/ui/widgets/notes_list_page_widgets/tag_display_widget.dart';

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
            fontSize: SizeConfig.blockSizeVertical * 4, color: Colors.white70),
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: AppColors.backgroundColor,
    );

    AppBar newAppBar = AppBar(
      toolbarHeight: SizeConfig.blockSizeVertical * 10,
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
        ),
      ),
      title: Text("${selectedList.length}"),
      actions: [
        widget.screenTitle == "Trash"
            ? IconButton(
                onPressed: () {
                  for (var i in selectedList) {
                    BlocProvider.of<FolderCubit>(context).addNoteToFolder(
                        'All Notes', widget.notesToBeDisplayed[i]);
                    BlocProvider.of<FolderCubit>(context).removeNoteFromFolder(
                        'Trash', widget.notesToBeDisplayed[i]);
                  }
                  setState(() {
                    selectedList = [];
                    triggerGlobalSelection = false;
                  });
                },
                icon: Icon(Icons.restore))
            : Text(''),
        IconButton(
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
              else {
                for (var note in selectedList) {
                  BlocProvider.of<FolderCubit>(context).removeNoteFromFolder("Trash", widget.notesToBeDisplayed[note]);
                }

                setState(() {
                  selectedList = [];
                  triggerGlobalSelection = false;
                });
              }
            }
            ,
            icon: Icon(Icons.delete)),
        IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
      ],
    );

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
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70,
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 2,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${NoteTileDisplay.displayTime(
                                      widget
                                          .notesToBeDisplayed[index].timeStamp,
                                    )}",
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(color: Colors.white38),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 3),
                                    child: Container(
                                      child: Text(
                                        "${NoteTileDisplay.displayContent(widget.notesToBeDisplayed[index].content)}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(color: Colors.white60),
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 2,
                              ),
                              Row(
                                children: [
                                  for (var tag in widget
                                      .notesToBeDisplayed[index].associatedTags)
                                    TagDisplayWidget(tag: tag),
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
