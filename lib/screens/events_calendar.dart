import 'package:flutter/material.dart';

import '../controllers/main_page_controller.dart';

import 'package:get/get.dart';

class EventsCalendar extends StatelessWidget {
  final MainPageController mainPageC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          child: Text('Dats Calendar. Go home'),
          onPressed: () {
            mainPageC.changePage(0);
          },
        ),
      ),
    );
  }
}
