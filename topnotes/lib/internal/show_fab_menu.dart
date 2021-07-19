import 'package:flutter/material.dart';
import 'package:topnotes/internal/size_config.dart';

class Utils {
  static void showFabMenu(BuildContext context, List<Widget> items) {
    Widget child = LayoutBuilder(
      builder: (_, constraints) {
        final width = constraints.biggest.width;
        final height = constraints.biggest.height;
        return Stack(
          children: [
            Positioned(
              bottom: height * 0.05,
              right: width * 0.05,
              child: Hero(
                tag: "fabMenu",
                child: Material(
                  elevation: 2,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(SizeConfig.blockSizeVertical),
                  ),
                  child: SizedBox(
                    width: height < 600
                        ? width / 1.65
                        : height < 900
                            ? width / 1.8
                            : width < 700
                                ? width / 2.2
                                : width / 3.5,
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
      },
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
