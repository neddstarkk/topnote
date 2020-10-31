import 'package:flutter/material.dart';
import 'package:topnotes/utils/constants.dart';
import 'package:topnotes/utils/size_config.dart';

class CustomAppBarRow extends StatelessWidget {
  const CustomAppBarRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
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
    );
  }
}