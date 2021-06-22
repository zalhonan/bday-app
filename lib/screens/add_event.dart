import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'package:intl/intl.dart';

import '../controllers/events_storage.dart';
import '../services/constants.dart';
import '../widgets/event_chosing_title.dart';
import '../widgets/keyboard_wise_scroller.dart';
import '../models/event.dart';

void addEvent({required BuildContext context, required bool isNew}) {
  // * isNew - true если новое событие, false если событие редактируется
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddEvent(
          isNew: isNew,
        );
      });
}

class AddEvent extends StatefulWidget {
  final bool isNew;

  const AddEvent({
    Key? key,
    required this.isNew,
  }) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  var uuid = Uuid();

  String _id = "";
  int _eventKind = 0;
  String _personName = "";
  List<bool> _reminders = [true, false, false, false];
  bool _yearKnown = true;
  DateTime _startDate = DateTime.now();
  DateTime _reminderTime =
      DateFormat('dd-MM-yyyy h:mm', 'ru_RU').parseLoose('01-11-2020 9:00');

  // * предовращение обновления
  bool _loaded = false;

  // * найдём общее хранилище эвентов
  final EventsStorage eventsStorage = Get.find();

  @override
  Widget build(BuildContext context) {
    // * если это не новый эвент - загружаем из хранилища нужный и раскладываем во все поля.
    // * для нового генерируем id
    if (widget.isNew) {
      _id = uuid.v1();
    } else if (!_loaded) {
      // * находим элемент по ID и раскладываем в поля формы
      Event eventToFix = eventsStorage.getEventIdSet;
      _id = eventToFix.id;
      _eventKind = eventToFix.eventKind;
      _personName = eventToFix.personName;
      _reminders = [
        eventToFix.notifyToday,
        eventToFix.notifyTomorrow,
        eventToFix.notify3Days,
        eventToFix.notifyWeek
      ];
      _yearKnown = eventToFix.yearKnown;
      _startDate = eventToFix.startDate;
      _reminderTime = eventToFix.reminderTime;

      _loaded = true;
    }

    return Container(
      height: Get.height / 6 * 5,
      child: Column(
        children: [
          Expanded(
            child: Scrollbar(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // * заголовок
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            widget.isNew
                                ? "Создайте событие (скролл вниз для подтверждения)"
                                : "Редактиврование события (скролл вниз для подтверждения)",
                            style: TextStyle(
                              fontSize: kFontSizeHeadline5,
                            ),
                          ),
                        ),

                        // * Ввод имени
                        EventChosingTitle(title: "Имя или название события"),

                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            initialValue: _personName,
                            decoration: InputDecoration(
                              hintText: 'Имя персоны или название события',
                              // labelText: 'Название события',
                            ),
                            onChanged: (value) {
                              _personName = value;
                            },
                          ),
                        ),

                        // * выбор типа события
                        EventChosingTitle(title: "Тип события"),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i = 0; i < 5; i++)
                              RadioListTile<int>(
                                title:
                                    Text("${kEventEmoji[i]} ${kEventName[i]}"),
                                value: i,
                                groupValue: _eventKind,
                                onChanged: (value) {
                                  setState(() {
                                    _eventKind = value ?? _eventKind;
                                  });
                                },
                              ),
                          ],
                        ),

                        // * Дата события + известен ли год
                        EventChosingTitle(
                            title: "Дата первоначального события"),

                        Container(
                          height: 200,
                          width: Get.width,
                          margin: EdgeInsets.fromLTRB(
                              Get.width * 0.25, 0, Get.width * 0.25, 0),
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            use24hFormat: true,
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (DateTime startDate) {
                              setState(() {
                                _startDate = startDate;
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
                            for (var i = 0; i < 4; i++)
                              CheckboxListTile(
                                title: Text("${kReminders[i]}"),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
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
                          margin: EdgeInsets.fromLTRB(
                              Get.width * 0.25, 0, Get.width * 0.25, 0),
                          width: Get.width,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            use24hFormat: true,
                            initialDateTime: _reminderTime,
                            onDateTimeChanged: (DateTime reminderTime) {
                              setState(() {
                                _reminderTime = reminderTime;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                    Event eventToAdd = Event(
                      id: _id,
                      eventKind: _eventKind,
                      personName: _personName,
                      yearKnown: _yearKnown,
                      startDate: _startDate,
                      systemNotifications: false,
                      notifyToday: _reminders[0],
                      notifyTomorrow: _reminders[1],
                      notify3Days: _reminders[2],
                      notifyWeek: _reminders[3],
                      reminderTime: _reminderTime,
                    );

                    if (widget.isNew) {
                      // * для нового элемента - запись в хранилище
                      eventsStorage.addEvent(eventToAdd);
                    } else {
                      // * редактирование: найти по id и заменить
                      eventsStorage.editEvent(eventToAdd);
                    }
                    Get.back();
                  },
                  child: Text(widget.isNew
                      ? "Добавить событие"
                      : "Отредактировать событие"),
                ),
                if (!widget.isNew)
                  OutlinedButton(
                    onPressed: () {
                      eventsStorage.deleteElement(_id);
                      Get.back();
                    },
                    child: Text(
                      "Удалить",
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red),
                    ),
                  ),
                OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Отменить"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
