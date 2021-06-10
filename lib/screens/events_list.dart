import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/events_randomizer.dart';
import '../models/event.dart';
import '../widgets/events_filter_chip.dart';

import '../widgets/event_card.dart';

import '../controllers/events_storage.dart';
import '../controllers/events_list_controller.dart';

class EventsList extends StatelessWidget {
  EventsList({Key? key}) : super(key: key);

  // * создание контроллера

  final EventsListController eventsListC = Get.put(EventsListController());

  // * поиск контроллеров

  final EventsStorage eventsStorage = Get.find();

  @override
  Widget build(BuildContext context) {
    // * инициализация фильтра
    eventsListC.setFilter(-1);

    return Obx(() {
      var setFilter = eventsListC.filter.value;

      var filteredList = eventsStorage.eventsList.value
          .where(
              (element) => (element.eventKind == setFilter || setFilter == -1))
          .toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var i = -1; i < 5; i++)
                  EventsFilterChip(
                    changeTo: i,
                    stateFilter: eventsListC.filter.value,
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return EventCard(event: filteredList[index]);
              },
              itemCount: filteredList.length,
            ),
          ),
        ],
      );
    });
  }
}
