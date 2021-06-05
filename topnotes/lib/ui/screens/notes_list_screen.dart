import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/folders/folder_cubit.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String displayTime(DateTime timeStamp) {
    const Map<int, String> monthsInYear = {
      1: "January",
      2: "February",
      3: "March",
      4: "April",
      5: "May",
      6: "June",
      7: "July",
      8: "August",
      9: "September",
      10: "October",
      11: "November",
      12: "December",
    };
    return "${timeStamp.day} ${monthsInYear[timeStamp.month]}, ${timeStamp.year}";
  }

  String displayContent(String content) {
    if (content.contains('\n')) {
      var str = content.replaceAll('\n', ' ');
      return str;
    }

    return content;
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
        body: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Folder Title
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 4,
                      left: SizeConfig.blockSizeHorizontal * 4,
                      bottom: SizeConfig.safeBlockVertical * 2),
                  child: Text(
                    "${widget.screenTitle}",
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 4,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 4),
                  child: widget.notesToBeDisplayed.length == 0
                      ? EmptyStateWidget()
                      : GridView.builder(
                          reverse: true,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.notesToBeDisplayed.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: SizeConfig.blockSizeVertical * 2,
                            crossAxisSpacing:
                                SizeConfig.blockSizeHorizontal * 2,
                            childAspectRatio: 3.0,
                          ),
                          itemBuilder: (context, index) => GestureDetector(
                            onTapDown: _storePosition,
                            onLongPress: () {
                              final RenderBox overlay = Overlay.of(context)
                                  .context
                                  .findRenderObject();
                              showMenu(
                                context: context,
                                items: [
                                  PopupMenuItem(
                                    value: 0,
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete),
                                        Text("Delete"),
                                      ],
                                    ),
                                  ),
                                  widget.screenTitle == 'Trash'
                                      ? PopupMenuItem(
                                          value: 1,
                                          child: Row(
                                            children: [
                                              Icon(Icons.restore),
                                              Text("Restore"),
                                            ],
                                          ),
                                        )
                                      : null,
                                ],
                                position: RelativeRect.fromRect(
                                  tapPosition & const Size(40, 40),
                                  Offset.zero & overlay.size,
                                ),
                              ).then((value) {
                                if (value == null)
                                  return;
                                else if (value == 0) {
                                  if (widget.screenTitle == "Trash") {
                                    setState(() {
                                      BlocProvider.of<FolderCubit>(context)
                                          .removeNoteFromFolder('Trash',
                                              widget.notesToBeDisplayed[index]);
                                    });
                                  } else {
                                    setState(() {
                                      BlocProvider.of<FolderCubit>(context)
                                          .moveNoteToTrash(
                                              widget.notesToBeDisplayed[index]);
                                    });
                                  }
                                } else if (value == 1) {
                                  setState(
                                    () {
                                      BlocProvider.of<FolderCubit>(context)
                                          .addNoteToFolder('All Notes',
                                              widget.notesToBeDisplayed[index]);
                                      BlocProvider.of<FolderCubit>(context)
                                          .removeNoteFromFolder('Trash',
                                              widget.notesToBeDisplayed[index]);
                                    },
                                  );
                                }
                              });
                            },
                            onTap: () async {
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
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFBEBEDF),
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
                                          fontSize:
                                              SizeConfig.blockSizeVertical * 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "${displayTime(
                                          widget.notesToBeDisplayed[index]
                                              .timeStamp,
                                        )}",
                                        overflow: TextOverflow.fade,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3),
                                          child: Container(
                                            child: Text(
                                              "${displayContent(widget.notesToBeDisplayed[index].content)}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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

                                            borderRadius: BorderRadius.circular(
                                              SizeConfig.blockSizeVertical * 10,
                                            ),
                                          ),
                                          child: Text(
                                            "#${tag.tagName}",

                                          ),
                                        ),
                                      Spacer(),
                                      Icon(
                                        Icons.star,
                                        color: widget.notesToBeDisplayed[index]
                                                    .isFavorite ==
                                                true
                                            ? Colors.amber
                                            : ThemeData().primaryColor,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
