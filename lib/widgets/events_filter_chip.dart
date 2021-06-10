import 'package:events/controllers/events_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/main_page_controller.dart';
import '../services/constants.dart';

class EventsFilterChip extends StatelessWidget {
  EventsFilterChip({
    Key? key,
    required this.changeTo,
    required this.stateFilter,
  }) : super(key: key);

  final int changeTo;
  final int stateFilter;

  final EventsListController eventsListC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 6, 0, 6),
      child: GestureDetector(
        child: Chip(
          avatar: Text(kEventEmoji[changeTo] ?? "🗺"),
          label: Text(kEventNameShort[changeTo] ?? "События"),
          elevation: 4,
          backgroundColor: stateFilter == changeTo ? Colors.white : Colors.grey,
        ),
        onTap: () {
          eventsListC.setFilter(changeTo);
        },
      ),
    );
  }
}
