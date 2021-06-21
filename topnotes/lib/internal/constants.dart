import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteTileDisplay {
  static String displayTime(DateTime timeStamp) {
    const Map<int, String> monthsInYear = {
      1: "January",
      2: "February",
      3: "March",
      4: "April",
      5: "May",
      6: "June",
      7: "July",
      8: "August",
      9: "September",
      10: "October",
      11: "November",
      12: "December",
    };
    return "${timeStamp.day} ${monthsInYear[timeStamp.month]}, ${timeStamp.year}";
  }

  static String displayContent(String content) {
    if (content.contains('\n')) {
      var str = content.replaceAll('\n', ' ');
      return str;
    }

    return content;
  }
}

Color iconColor = Colors.white70;

class AppColors {
  static Color backgroundColor = Color(0xFF1C1C1C);
  static Color textColor = Colors.white70;
}

TextStyle textStyle = TextStyle(color: AppColors.textColor);

var appBarContextButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
      (states) => StadiumBorder()),
  overlayColor: MaterialStateProperty.resolveWith((states) => Colors.white10),
  foregroundColor: MaterialStateProperty.resolveWith((states) => iconColor),
);
