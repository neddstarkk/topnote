import 'package:flutter/material.dart';
import 'package:topnotes/internal/constants.dart';
import 'package:topnotes/internal/size_config.dart';
import 'package:topnotes/ui/widgets/home_screen_widgets/custom_appbar_row.dart';

class TopnotesText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 4,
          left: SizeConfig.blockSizeHorizontal * 4,
          bottom: SizeConfig.blockSizeVertical * 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "TopNotes",
            style: headerTextStyle.copyWith(
              fontSize: SizeConfig.blockSizeVertical * 4,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: CustomAppBarRow(),
          ),
        ],
      ),
    );
  }
}
