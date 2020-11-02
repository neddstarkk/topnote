import 'package:flutter/material.dart';
import 'package:topnotes/internal/utils/global_key_registry.dart';
import 'package:topnotes/internal/utils/size_config.dart';

class Utils {
  static void showFabMenu(BuildContext context, List<Widget> items) {
    RenderBox fabBox =
        GlobalKeyRegistry.get("fab").currentContext.findRenderObject();

    Size fabSize = fabBox.size;
    Offset fabPosition = fabBox.localToGlobal(Offset(0, 0));

    Widget child = Stack(
      children: [
        Positioned(
          bottom: MediaQuery.of(context).size.height -
              (fabPosition.dy + fabSize.height),
          right: MediaQuery.of(context).size.width -
              (fabPosition.dx + fabSize.width),
          child: Hero(
            tag: "fabMenu",
            child: Material(
              color: Color(0xFF1C303F),
              elevation: 2,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(SizeConfig.blockSizeVertical),
              ),
              child: SizedBox(
                width: SizeConfig.screenWidth / 2.1,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(0),
                  reverse: true,
                  children: items,
                ),
              ),
            ),
          ),
        )
      ],
    );

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, anim, secAnim) => child,
        opaque: false,
        barrierDismissible: true,
      ),
    );
  }
}
