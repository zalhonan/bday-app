import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import '../controllers/main_page_controller.dart';

class CommonNavbar extends StatelessWidget {
  final int navigationState;

  CommonNavbar({
    Key? key,
    required this.navigationState,
  }) : super(key: key);

  // * запрос контроллера главной страницы
  final MainPageController mainPageC = Get.find();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'События',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.calendar),
          label: 'Календарь',
          backgroundColor: Colors.purple,
        ),
        // BottomNavigationBarItem(
        //   icon: FaIcon(FontAwesomeIcons.envelope),
        //   label: 'Открытки',
        //   backgroundColor: Colors.cyan,
        // ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.settings),
        //   label: 'Настройки',
        //   backgroundColor: Colors.pink,
        // ),
      ],
      currentIndex: navigationState,
      onTap: (index) {
        mainPageC.changePage(index);
      },
    );
  }
}
