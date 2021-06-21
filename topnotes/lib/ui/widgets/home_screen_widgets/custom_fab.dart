import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topnotes/internal/global_key_registry.dart';
import 'package:topnotes/internal/utils.dart';
import 'package:topnotes/internal/size_config.dart';

import 'fake_fab.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Function _onTap;
  final ScrollController _scrollController;
  final List<Widget> _fabOptions;

  CustomFloatingActionButton({
    @required Function onTap,
    @required ScrollController scrollController,
    @required List<Widget> fabOptions,
    Key key,
  })  : this._onTap = onTap,
        this._scrollController = scrollController,
        this._fabOptions = fabOptions,
        super(key: key);

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
        onTap: _onTap,
        child: Icon(
          Icons.add,
          color: Color(0xFFDAC279),
          size: SizeConfig.blockSizeVertical * 3,
        ),
      ),
    );
  }
}
