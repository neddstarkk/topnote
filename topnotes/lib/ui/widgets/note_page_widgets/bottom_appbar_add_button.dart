import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topnotes/cubits/tags/tag_cubit.dart';
import 'package:topnotes/data/models/tags_model.dart';
import 'package:topnotes/internal/size_config.dart';

class BottomAppBarAddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 5,
      width: SizeConfig.blockSizeVertical * 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(SizeConfig.blockSizeVertical * 1.6),
        ),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.blockSizeVertical * 1.6),
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              height: SizeConfig.blockSizeVertical * 12,
              width: SizeConfig.screenWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.folder_open_outlined,
                    ),
                    title: Text(
                      "Add to folder",
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.local_offer_outlined,
                    ),
                    title: Text(
                      "Add tags",
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => addTagsToNote(),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
        child: Icon(
          Icons.more_vert,
        ),
      ),
    );
  }

  addTagsToNote() {
    return AlertDialog(
      title: Text("Select Tags"),
      content: BlocBuilder<TagCubit, List<Tag>>(builder: (context, state) {
        return Container(
          width: 100,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text("${state[index].tagName}"),
                  value: state[index].isSelected,
                  onChanged: (newVal) {},
                );
              }),
        );
      }),
      actions: [
        TextButton(
          child: Text("ADD"),
          onPressed: () {},
        )
      ],
    );
  }
}
