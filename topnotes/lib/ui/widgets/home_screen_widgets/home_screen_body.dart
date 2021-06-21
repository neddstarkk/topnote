import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:topnotes/cubits/tags/tag_cubit.dart';
import 'package:topnotes/data/models/tags_model.dart';

import 'package:topnotes/ui/widgets/home_screen_widgets/tags_text.dart';

import 'folder_text.dart';
import 'folders_display.dart';

class HomeScreenBody extends StatelessWidget {
  final ScrollController _scrollController;
  final bool _deleteState;
  final Function _onLongPress;

  const HomeScreenBody(
      {Key key,
      @required ScrollController scrollController,
      bool deleteState,
      Function onLongPress})
      : this._scrollController = scrollController,
        this._deleteState = deleteState,
        this._onLongPress = onLongPress,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _scrollController,
      physics: BouncingScrollPhysics(),
      children: [
        // TopNotes text padding
        // TopnotesText(),

        // Folders text padding
        FolderText(),

        // Folders Listview

        FoldersDisplay(),

        // Tags text padding
        TagsText(),

        // tags list view
        BlocBuilder<TagCubit, List<Tag>>(
          builder: (context, state) {
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.8,
              ),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onLongPress: _onLongPress,
                  child: Chip(
                    avatar: Icon(Icons.tag),
                    label: Text("${state[index].tagName}"),
                    useDeleteButtonTooltip: false,
                    deleteIcon: _deleteState == false
                        ? Text("${state[index].notesUnderTag.length}")
                        : Icon(
                            Icons.clear,
                            color: Colors.red,
                          ),
                    onDeleted: () {},
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
