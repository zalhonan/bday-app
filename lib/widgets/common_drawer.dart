import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../services/constants.dart';
import '../services/events_randomizer.dart';

import '../controllers/auth_controller.dart';
import '../controllers/events_storage.dart';

class CommonDrawer extends StatelessWidget {
  final AuthController authC = Get.find();
  final EventsStorage eventsStorage = Get.find();

  @override
  Widget build(BuildContext context1) {
    return Obx(
      () {
        return Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(color: Colors.blue),
                child: ListTile(
                  leading: Icon(
                    authC.isAuthorized.value
                        ? Icons.account_circle_outlined
                        : Icons.circle_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    authC.isAuthorized.value
                        ? "Авторизованный пользователь"
                        : "Анонимный пользователь",
                    style: TextStyle(
                        color: Colors.white, fontSize: kFontSizeHeadline6),
                  ),
                  dense: true,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    authC.isAuthorized.value
                        // * авторизованный юзер
                        ? Column(
                            children: [
                              // * пункт только для админа

                              authC.isAdmin.value
                                  ? ListTile(
                                      leading: FaIcon(FontAwesomeIcons.listOl),
                                      title: Text('Заполнить 300 событий'),
                                      onTap: () {
                                        // * создание и сортировка списка событий для eventsStorage
                                        var eventRandomizer = EventsRandomizer(
                                            eventsAmount: 300,
                                            startYear: 1913,
                                            endYear: 2024);
                                        var randomEvents =
                                            eventRandomizer.getEvents();

                                        randomEvents.sort((a, b) => a
                                            .eventInDays
                                            .compareTo(b.eventInDays));

                                        eventsStorage.setEvents(randomEvents);
                                        print("300!");
                                      },
                                    )
                                  : Container(),
                            ],
                          )
                        // * неавторизованному - ничего
                        : Container(),
                    authC.isAuthorized.value
                        // * авторизованный юзер
                        ? Column(
                            children: [
                              ListTile(
                                leading: FaIcon(FontAwesomeIcons.signOutAlt),
                                title: Text('Выйти из системы'),
                                onTap: () {
                                  authC.logout();
                                  Get.back();
                                },
                              ),
                            ],
                          )
                        // * неавторизованный юзер
                        : Column(
                            children: [
                              ListTile(
                                leading: FaIcon(FontAwesomeIcons.userPlus),
                                title: Text('Зарегистрироваться'),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                              ListTile(
                                leading: FaIcon(FontAwesomeIcons.signInAlt),
                                title: Text('Авторизоваться'),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                              ListTile(
                                leading: FaIcon(FontAwesomeIcons.signInAlt),
                                title: Text('Войти админом'),
                                onTap: () {
                                  authC.login();
                                  authC.makeAdmin();
                                },
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
