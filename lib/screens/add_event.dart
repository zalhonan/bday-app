import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/constants.dart';
import '../widgets/event_chosing_title.dart';
import '../widgets/keyboard_wise_scroller.dart';
import '../controllers/events_storage.dart';

void addEvent(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddEvent();
      });
}

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int _kind = 0;
  String _name = "";
  List<bool> _reminders = [true, false, false, false, false];
  bool _yearKnown = true;
  DateTime _initialDate = DateTime.now();
  DateTime _reminderTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 4 * 3,
      child: KeyboardWiseScroller(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // * заголовок
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Создайте или отредактируйте событие",
                style: TextStyle(
                  fontSize: kFontSizeHeadline5,
                ),
              ),
            ),

            // * выбор типа события
            EventChosingTitle(title: "Тип события"),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < 5; i++)
                  RadioListTile<int>(
                    title: Text("${kEventEmoji[i]} ${kEventName[i]}"),
                    value: i,
                    groupValue: _kind,
                    onChanged: (value) {
                      setState(() {
                        _kind = value ?? 0;
                      });
                    },
                  ),
              ],
            ),
            // * Ввод имени
            EventChosingTitle(title: "Имя или название события"),

            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                initialValue: _name,
                decoration: InputDecoration(
                  hintText: 'Имя персоны или название события',
                  // labelText: 'Название события',
                ),
                onChanged: (value) {
                  _name = value;
                },
              ),
            ),

            // * Дата события + известен ли год
            EventChosingTitle(title: "Дата первоначального события"),

            Container(
              height: 200,
              width: Get.width,
              margin:
                  EdgeInsets.fromLTRB(Get.width * 0.25, 0, Get.width * 0.25, 0),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                use24hFormat: true,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime startDate) {
                  setState(() {
                    _initialDate = startDate;
                  });
                },
              ),
            ),

            CheckboxListTile(
              title: Text("Год события известен"),
              controlAffinity: ListTileControlAffinity.leading,
              value: _yearKnown,
              onChanged: (value) {
                setState(() {
                  _yearKnown = value ?? true;
                });
              },
            ),

            // * выбор дней для напоминаний
            EventChosingTitle(title: "Дни напоминаний"),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < 5; i++)
                  CheckboxListTile(
                    title: Text("${kReminders[i]}"),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _reminders[i],
                    onChanged: (value) {
                      setState(() {
                        _reminders[i] = value ?? false;
                      });
                    },
                  ),
              ],
            ),
            // * выбор времени для напоминаний
            EventChosingTitle(title: "Время напоминания"),

            Container(
              height: 200,
              margin:
                  EdgeInsets.fromLTRB(Get.width * 0.25, 0, Get.width * 0.25, 0),
              width: Get.width,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                use24hFormat: true,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime reminderTime) {
                  setState(() {
                    _reminderTime = reminderTime;
                    print(_reminderTime);
                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print("new event set");
                    },
                    child: Text("Добавить событие"),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Отменить"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
