import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/navigation_cubit.dart';
import 'cubits/events_cubit.dart';
import 'cubits/filter_events_cubit.dart';

import 'screens/main_page.dart';

import 'models/event.dart';

import 'services/events_randomizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // * создание и сортировка списка событий для кубита
    var eventRandomizer =
        EventsRandomizer(eventsAmount: 300, startYear: 1913, endYear: 2024);
    var randomEvents = eventRandomizer.getEvents();

    randomEvents.sort((a, b) => a.eventInDays.compareTo(b.eventInDays));

    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(),
        ),
        BlocProvider<EventsCubit>(
          create: (context) => EventsCubit(randomEvents),
        ),
        BlocProvider<FilterEventsCubit>(
          create: (context) => FilterEventsCubit(-1),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Events and cards',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Noto',
        ),
        home: MainPage(),
      ),
    );
  }
}
