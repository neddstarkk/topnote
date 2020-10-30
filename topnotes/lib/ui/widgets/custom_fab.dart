import 'package:flutter/material.dart';
import 'package:topnotes/utils/size_config.dart';

class CustomFAB extends StatefulWidget {
  CustomFAB({
    Key key,
    @required this.selected,
  }) : super(key: key);

  bool selected;

  @override
  _CustomFABState createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            widget.selected
                ? SizeConfig.blockSizeVertical * 2.5
                : SizeConfig.blockSizeVertical * 10,
          ),
        ),
      ),
      height: widget.selected
          ? SizeConfig.blockSizeVertical * 27.5
          : SizeConfig.blockSizeVertical * 6.5,
      width: widget.selected
          ? SizeConfig.blockSizeVertical * 20
          : SizeConfig.blockSizeVertical * 6.5,
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(
          widget.selected
              ? SizeConfig.blockSizeVertical * 2.5
              : SizeConfig.blockSizeVertical * 10,
        )),
        color: Color(0xFF1C303F),
        child: InkWell(
          onLongPress: () {
            setState(() {
              widget.selected = !widget.selected;
            });
          },
          borderRadius: BorderRadius.all(Radius.circular(
            widget.selected
                ? SizeConfig.blockSizeVertical * 2.5
                : SizeConfig.blockSizeVertical * 10,
          )),
          child: Icon(
            Icons.create,
            color: Color(0xFFDAC279),
          ),
        ),
      ),
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }
}
