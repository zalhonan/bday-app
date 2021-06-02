import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/event.dart';
import '../services/constants.dart';

import 'package:random_color/random_color.dart';

class EventCard extends StatelessWidget {
  final Event event;
  EventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  final RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 8,
                  ),
                  Text(
                    event.personName,
                    style: TextStyle(fontSize: kCardHeadlineFontSize),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Container(
                    height: 6,
                  ),
                  Text(
                    event.eventDate,
                    style: TextStyle(fontSize: kCardSubtextFontSize),
                  ),
                  Text(
                    event.eventDescription,
                    style: TextStyle(
                      fontSize: kCardSubtextFontSize,
                      color: event.eventInDays >= -1 && event.eventInDays <= 1
                          ? kColorAccentRed
                          : kColorAccent,
                    ),
                  ),
                  Container(
                    height: 6,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Chip(
                        backgroundColor: Colors.white,
                        elevation: 4,
                        avatar: Icon(
                          Icons.settings,
                          color: Colors.grey,
                          size: 24,
                        ),
                        label: Text("Настройки"),
                      ),
                      Container(
                        width: 6,
                      ),
                      Chip(
                        backgroundColor: Colors.white,
                        elevation: 4,
                        avatar: Container(
                          padding: EdgeInsets.only(left: 6),
                          child: FaIcon(
                            FontAwesomeIcons.envelope,
                            color: Colors.grey,
                            size: 24,
                          ),
                        ),
                        label: Container(
                          padding: EdgeInsets.only(left: 6),
                          child: Text("Открытка"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 88,
              width: 88,
              color: _randomColor.randomColor(
                  colorBrightness: ColorBrightness.light),
              child: Center(
                child: event.eventPicture,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
