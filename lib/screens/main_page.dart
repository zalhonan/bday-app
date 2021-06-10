import 'package:flutter/material.dart';

import '../screens/add_event.dart';
import '../screens/app_settings.dart';
import '../screens/events_calendar.dart';
import '../screens/events_list.dart';
import '../screens/make_card.dart';

import '../controllers/main_page_controller.dart';
import '../controllers/events_storage.dart';

import '../services/events_randomizer.dart';

import '../widgets/common_drawer.dart';
import '../widgets/common_navbar.dart';

import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  // * Основная страница навигации

  // * Создаём экземпляры контроллеров помощью Get.put(), чтобы сделать их доступнымы дочерним маршрутам

  final MainPageController mainPageC = Get.put(MainPageController());

  final EventsStorage eventsStorage = Get.put(EventsStorage());

  // * Страницы в навигации

  final List<Widget> _widgetOptions = [
    EventsList(),
    AddEvent(),
    EventsCalendar(),
    MakeCard(),
    AppSettings(),
  ];

  // * Заголовки - названия страниц в навигации

  final List<String> _widgetNames = [
    "Список событий",
    "Добавление и редактирование",
    "Календарь событий",
    "Создать открытку",
    "Настройки приложения",
  ];

  @override
  Widget build(BuildContext context) {
    // * создание и сортировка списка событий для eventsStorage
    var eventRandomizer =
        EventsRandomizer(eventsAmount: 300, startYear: 1913, endYear: 2024);
    var randomEvents = eventRandomizer.getEvents();

    randomEvents.sort((a, b) => a.eventInDays.compareTo(b.eventInDays));

    eventsStorage.setEvents(randomEvents);

    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              _widgetNames.elementAt(mainPageC.page.value),
            ),
          ),
          drawer: CommonDrawer(),
          body: Center(
            child: _widgetOptions.elementAt(mainPageC.page.value),
          ),
          bottomNavigationBar: CommonNavbar(
            navigationState: mainPageC.page.value,
          ),
        );
      },
    );
  }
}
