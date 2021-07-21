class Utils {
  static int tagDisplayLength(double width, List<dynamic> associatedTags) {
    if (width < 350) {
      if (associatedTags.length < 4) {
        return associatedTags.length;
      } else {
        return 3;
      }
    } else if (width < 450) {
      if (associatedTags.length < 5) {
        return associatedTags.length;
      } else {
        return 4;
      }
    }

    if (associatedTags.length < 6) {
      return associatedTags.length;
    } else
      return 5;
  }
}