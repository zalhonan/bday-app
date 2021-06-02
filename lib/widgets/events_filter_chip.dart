import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/filter_events_cubit.dart';

import '../services/constants.dart';

class EventsFilterChip extends StatelessWidget {
  final BuildContext context;
  final int changeTo;
  final int stateFilter;

  const EventsFilterChip({
    Key? key,
    required this.context,
    required this.changeTo,
    required this.stateFilter,
  }) : super(key: key);

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
          context.read<FilterEventsCubit>().changeFilter(changeTo);
        },
      ),
    );
  }
}
