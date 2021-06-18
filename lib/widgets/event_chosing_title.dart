import 'package:flutter/material.dart';

import '../services/constants.dart';

class EventChosingTitle extends StatelessWidget {
  const EventChosingTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: kFontSizeHeadline6,
        ),
      ),
    );
  }
}
