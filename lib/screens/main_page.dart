import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/events_storage.dart';
import '../controllers/main_page_controller.dart';
import '../controllers/auth_controller.dart';

import '../screens/add_event.dart';
import '../screens/app_settings.dart';
import '../screens/events_calendar.dart';
import '../screens/events_list.dart';
import '../screens/make_card.dart';
import '../services/events_randomizer.dart';
import '../widgets/common_drawer.dart';
import '../widgets/common_navbar.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  // * Основная страница навигации

  // * Создаём экземпляры контроллеров помощью Get.put(), чтобы сделать их доступнымы дочерним маршрутам

  final MainPageController mainPageC = Get.put(MainPageController());

  // * хранение эвентов
  final EventsStorage eventsStorage = Get.put(EventsStorage());

  // * авторизация
  final AuthController authController = Get.put(AuthController());

  // * Список виджетов - страницы в навигации
  final List<Widget> _widgetOptions = [
    EventsList(),
    EventsCalendar(),
    // MakeCard(),
    // AppSettings(),
  ];

  // * Список заголовков - названия страниц в навигации
  final List<String> _widgetNames = [
    "Список событий",
    "Календарь событий",
    // "Создать открытку",
    // "Настройки приложения",
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              _widgetNames.elementAt(mainPageC.page.value),
            ),
          ),
          drawer: CommonDrawer(),
          body: _widgetOptions.elementAt(mainPageC.page.value),
          bottomNavigationBar: CommonNavbar(
            navigationState: mainPageC.page.value,
          ),
          floatingActionButton: mainPageC.page.value == 0
              ? FloatingActionButton(
                  onPressed: () {
                    addEvent(context: context, isNew: true);
                  },
                  child: FaIcon(FontAwesomeIcons.calendarPlus),
                  backgroundColor: Colors.blue[600],
                )
              : null,
        );
      },
    );
  }
}
