import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration backgroundDecoration = BoxDecoration(color: Color(0xFF0C1720));

TextStyle tagTextStyle = TextStyle(
  color: Color(0xFF667079),
);

// Color tileIconColor = Color(0xFF2F4A5D);
//
// TextStyle headerTextStyle =
//     TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
//
// TextStyle tileTrailTextStyle = TextStyle(color: Color(0xFF667079));
//
// TextStyle noteTitleTextStyle = TextStyle(color: Color(0xFF6B737A));
//
// TextStyle noteContentTextStyle = TextStyle(color: Color(0xFF3E4750));

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

class AppColors {
  // static Color darkprimaryColor = Color(0xFF090809);
  // static Color primaryColor = Color(0xFF616161);
  // static Color lightPrimaryColor = Color(0xFFF5F5F5);
  // static Color primaryTextColor = Color(0xFF212121);
  //
  // static Color secondaryColor = Color(0xFFF40000);
  // static Color secondaryTextColor = Color(0xFF757575);
  //
  // static Color dividerColor = Color(0xFFBDBDBD);
}

