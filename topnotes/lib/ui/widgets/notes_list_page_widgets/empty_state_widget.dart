import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Empty State",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
