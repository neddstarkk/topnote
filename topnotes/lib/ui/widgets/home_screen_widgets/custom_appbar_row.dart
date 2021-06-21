import 'package:flutter/material.dart';
import 'package:topnotes/internal/size_config.dart';

class IconTextWidget extends StatelessWidget {
  final String text;
  final Icon icon;

  const IconTextWidget({
    this.icon,
    this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          icon,
          Padding(
            padding: EdgeInsets.only(
              right: SizeConfig.blockSizeHorizontal * 4,
              left: SizeConfig.blockSizeHorizontal,
            ),
            child: Text(
              "$text",
            ),
          )
        ],
      ),
    );
  }
}
