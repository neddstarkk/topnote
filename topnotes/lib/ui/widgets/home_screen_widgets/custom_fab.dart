import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topnotes/internal/global_key_registry.dart';
import 'package:topnotes/internal/utils.dart';
import 'package:topnotes/internal/size_config.dart';
import 'package:topnotes/ui/screens/note_page.dart';

import 'fake_fab.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Function _setState;
  final ScrollController _scrollController;
  final List<Widget> _fabOptions;

  const CustomFloatingActionButton(
      this._setState, this._scrollController, this._fabOptions,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "fabMenu",
      child: FakeFab(
        controller: _scrollController,
        onLongPress: () {
          Utils.showFabMenu(context, _fabOptions);
        },
        key: GlobalKeyRegistry.get("fab"),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(SizeConfig.blockSizeVertical * 10),
        ),
        onTap: () async {
          var result = await Navigator.push(
              context, CupertinoPageRoute(builder: (context) => NotePage()));
          if (result == true) {
            _setState(() {});
          }
        },
        child: Icon(
          Icons.add,
          color: Color(0xFFDAC279),
        ),
      ),
    );
  }
}
