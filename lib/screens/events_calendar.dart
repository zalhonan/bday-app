import 'package:flutter/material.dart';

import '../controllers/main_page_controller.dart';

import 'package:get/get.dart';

import 'package:table_calendar/table_calendar.dart';

import '../services/constants.dart';

// TODO: переписать без стейта на GetX

class EventsCalendar extends StatefulWidget {
  @override
  _EventsCalendarState createState() => _EventsCalendarState();
}

class _EventsCalendarState extends State<EventsCalendar> {
  final MainPageController mainPageC = Get.find();

  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          // * в дальнейших портах на другие языки привязать к локали
          availableCalendarFormats: const {
            CalendarFormat.month: 'Месяц',
            CalendarFormat.twoWeeks: '2 недели',
            CalendarFormat.week: 'Неделя',
          },
          locale: "RU_ru",
          focusedDay: _focusedDay,
          firstDay: kFirstDay,
          lastDay: kLastDay,
          calendarFormat: _calendarFormat,
          calendarStyle: CalendarStyle(
            // Use `CalendarStyle` to customize the UI
            outsideDaysVisible: false,
            canMarkersOverflow: true,
          ),
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          // TODO: выводить карточки событий по выбранному дню
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              // Call `setState()` when updating the selected day
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          onPageChanged: (focusedDay) {
            print(focusedDay);
            _focusedDay = focusedDay;
          },
          // TODO: возвращать для каждого дня +- 3 года набор событий. Смотреть производительность.
          eventLoader: (DateTime day) {
            if (isSameDay(day, DateTime(kNow.year, kNow.month, kNow.day - 2))) {
              return [1, 2, 3];
            } else {
              return [1, 2];
            }
          },
        ),
      ],
    );
  }
}
