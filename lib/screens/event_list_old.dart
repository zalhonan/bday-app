import 'package:flutter/material.dart';
import 'package:bday/widgets/event_card.dart';
import '../services/events_randomizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/events_cubit.dart';
import '../cubits/filter_events_cubit.dart';
import '../models/event.dart';

class EventsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Event> filteredList = [];

    return Scrollbar(
      child: BlocBuilder<FilterEventsCubit, int>(
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
                  Container(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 6,
                      ),
                      GestureDetector(
                        child: Chip(
                          label: Text("chips here"),
                        ),
                        onTap: () {
                          print("it tapped me oh");
                          contextFilter
                              .read<FilterEventsCubit>()
                              .changeFilter(3);
                        },
                      ),
                      Container(
                        width: 6,
                      ),
                      GestureDetector(
                        child: Chip(
                          label: Text("chips all now"),
                        ),
                        onTap: () {
                          print("it tapped me wow");
                          context.read<EventsCubit>().nulling();
                        },
                      ),
                    ],
                  ),
                  Container(
                    height: 8,
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
      ),
    );
  }
}
