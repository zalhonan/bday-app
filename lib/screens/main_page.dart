import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../cubits/navigation_cubit.dart';
import '../widgets/common_drawer.dart';
import 'add_event.dart';
import 'app_settings.dart';
import 'events_calendar.dart';
import 'events_list.dart';
import 'make_card.dart';

class MainPage extends StatelessWidget {
  final List<Widget> _widgetOptions = [
    EventsList(),
    AddEvent(),
    EventsCalendar(),
    MakeCard(),
    AppSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Список событий')),
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              Container(
                width: 6,
              ),
            ],
          ),
          drawer: CommonDrawer(),
          body: _widgetOptions.elementAt(context.read<NavigationCubit>().state),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'События',
                backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.calendarPlus),
                label: 'Добавить',
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.calendar),
                label: 'Календарь',
                backgroundColor: Colors.purple,
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.envelope),
                label: 'Открытки',
                backgroundColor: Colors.cyan,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Настройки',
                backgroundColor: Colors.pink,
              ),
            ],
            currentIndex: context.read<NavigationCubit>().state,
            onTap: (index) {
              context.read<NavigationCubit>().changePage(index);
            },
          ),
        );
      },
    );
  }
}
