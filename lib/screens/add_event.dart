import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_event_controller.dart';

void addEvent(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddEvent();
      });
}

class AddEvent extends StatelessWidget {
  final AddEventC addEventC = Get.put(AddEventC());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: MediaQuery.of(context).size.height / 4 * 3,
        child: Column(
          children: [
            RadioListTile<int>(
              title: const Text('Some test text'),
              value: 0,
              groupValue: addEventC.eventKind.value,
              onChanged: (value) {
                addEventC.selectKind(value ?? 0);
                print(value);
              },
            ),
            RadioListTile<int>(
              title: const Text('Some test text 2'),
              value: 1,
              groupValue: addEventC.eventKind.value,
              onChanged: (value) {
                addEventC.selectKind(value ?? 1);
                print(value);
              },
            ),
          ],
        ),
      );
    });
  }
}
