import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controllers/events_storage.dart';
import '../models/event.dart';
import '../services/constants.dart';
import '../widgets/event_card.dart';

class EventsCalendar extends StatelessWidget {
  final EventCalendarController c = Get.put(EventCalendarController());

  final EventsStorage eventsStorage = Get.find();

  @override
  Widget build(BuildContext context) {
    c.setEvents(eventsStorage.getEventsByDay(DateTime.now()));

    return Obx(() {
      return Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TableCalendar(
                // * в дальнейших портах на другие языки привязать к локали
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Месяц',
                  CalendarFormat.twoWeeks: '2 недели',
                  CalendarFormat.week: 'Неделя',
                },
                locale: "RU_ru",
                focusedDay: c.focusedDay.value,
                firstDay: kFirstDay,
                lastDay: kLastDay,
                calendarFormat: c.calendarFormat.value,
                calendarStyle: CalendarStyle(
                  // Use `CalendarStyle` to customize the UI
                  outsideDaysVisible: false,
                  canMarkersOverflow: true,
                ),
                // * выделение нужного дня
                selectedDayPredicate: (day) {
                  return isSameDay(c.selectedDay.value, day);
                },
                // Список для карточек событий по выбранному дню - формирование
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(c.selectedDay.value, selectedDay)) {
                    c.setSelectedDay(selectedDay);
                    c.setFocusedDay(focusedDay);
                  }
                  c.setEvents(eventsStorage.getEventsByDay(focusedDay));
                },
                // * смена формата календаря
                onFormatChanged: (format) {
                  c.setCalendarFormat(format);
                },
                // * сменя месяца (недели) - выбрать первое число, пересчитать события
                onPageChanged: (focusedDay) {
                  c.setFocusedDay(focusedDay);
                  c.setSelectedDay(focusedDay);
                  c.setEvents(eventsStorage.getEventsByDay(focusedDay));
                },
                // * сколько событий в данный день - отобразить точками
                eventLoader: (DateTime day) {
                  return eventsStorage.getEventsIdsByDay(day);
                },
              ),
              for (Event e in c.eventsThisDay) EventCard(event: e),
            ],
          ),
        ),
      );
    });
  }
}

class EventCalendarController extends GetxController {
  var calendarFormat = CalendarFormat.month.obs;

  setCalendarFormat(CalendarFormat newFormat) =>
      calendarFormat.value = newFormat;

  var focusedDay = DateTime.now().obs;

  setFocusedDay(DateTime newDay) => focusedDay.value = newDay;

  var selectedDay = DateTime.now().obs;

  setSelectedDay(DateTime newDay) => selectedDay.value = newDay;

  var eventsThisDay = [].obs;

  setEvents(List<Event> events) => eventsThisDay.value = events;
}
