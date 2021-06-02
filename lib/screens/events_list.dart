import 'package:flutter/material.dart';
import 'package:bday/widgets/event_card.dart';
import '../services/events_randomizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/events_cubit.dart';
import '../cubits/filter_events_cubit.dart';
import '../models/event.dart';
import '../widgets/events_filter_chip.dart';

class EventsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Event> filteredList = [];

    return BlocBuilder<FilterEventsCubit, int>(
      builder: (contextFilter, stateFilter) {
        return BlocBuilder<EventsCubit, List<Event>>(
          builder: (context, state) {
            filteredList = state
                .where((element) =>
                    (element.eventKind == stateFilter || stateFilter == -1))
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
                          context: contextFilter,
                          changeTo: i,
                          stateFilter: stateFilter,
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
          },
        );
      },
    );
  }
}
