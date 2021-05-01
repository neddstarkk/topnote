import 'package:flutter/material.dart';
import 'package:topnotes/internal/size_config.dart';

class NoteTakingMechanisms extends StatelessWidget {
  const NoteTakingMechanisms({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: SizeConfig.blockSizeHorizontal,
          ),
          ButtonTheme(
            minWidth: SizeConfig.blockSizeHorizontal * 8,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    SizeConfig.blockSizeVertical * 5)),
            child: TextButton(
              onPressed: () {},
              child: Icon(
                Icons.check_box_outlined,
                color: Colors.white70,
              ),
              style: ButtonStyle(
                padding:
                MaterialStateProperty.all(EdgeInsets.all(0.0)),
                overlayColor:
                MaterialStateProperty.all(Colors.white10),
              ),
            ),
          ),
          ButtonTheme(
            minWidth: SizeConfig.blockSizeHorizontal * 8,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    SizeConfig.blockSizeVertical * 5)),
            child: TextButton(
              onPressed: () {},
              child: Icon(
                Icons.image_outlined,
                color: Colors.white70,
              ),
              style: ButtonStyle(
                padding:
                MaterialStateProperty.all(EdgeInsets.all(0.0)),
                overlayColor:
                MaterialStateProperty.all(Colors.white10),
              ),
            ),
          )
        ],
      ),
    );
  }
}