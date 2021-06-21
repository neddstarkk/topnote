import 'package:flutter/material.dart';
import 'package:topnotes/internal/size_config.dart';

class ContentTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      style: TextStyle(
        fontSize: SizeConfig.blockSizeVertical * 2,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Content",
        hintStyle: TextStyle(
          fontSize: SizeConfig.blockSizeVertical * 2,
        ),
      ),
    );
  }
}
