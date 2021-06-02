import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../services/constants.dart';

import 'package:intl/intl.dart';

import "../services/datesProcessor.dart";

// ! Вид события
// * 0 birthday,
// * 1 wedding_anniversary,
// * 2 annual_meeting,
// * 3 rememberance_day,
// * 4 anniversary,

class Event {
  final int eventKind;
  final String personName;
  final bool yearKnown;
  final DateTime startDate;
  final bool systemNotifications;
  final bool notifyToday;
  final bool notifyTomorrow;
  final bool notify3Days;
  final bool notifyWeek;
  DatesProcessor datesProcessor;

  Event({
    required this.eventKind,
    required this.personName,
    required this.yearKnown,
    required this.startDate,
    required this.systemNotifications,
    required this.notifyToday,
    required this.notifyTomorrow,
    required this.notify3Days,
    required this.notifyWeek,
  }) : datesProcessor = DatesProcessor(
          languageCode: 'ru',
          todayDate: DateTime.now(),
          inputDate: startDate,
        );

  String get eventDate {
    // * геттер - дата в формате "🎂 День рождения 16 сентября"

    String res = (kEventEmoji[eventKind] ?? "📅") + " ";
    res += (kEventName[eventKind] ?? "Годовщина") + " ";
    res += "${startDate.day} ${kMonthName[startDate.month]}";
    return res;
  }

  int get eventInDays {
    // * геттер - возвращает через сколько дней событие. Сортируем по нему

    return datesProcessor.daysBetweenToday();
  }

  Widget get eventPicture {
    // * Эмоджи события по словарю в константах

    return Text(
      kEventEmoji[eventKind] ?? "📅",
      style: TextStyle(
        fontSize: 48,
      ),
    );
  }

  String get eventDescription {
    // * описание события "через 15 дней, исполняется 8 лет"

    // String res = inDays(daysBetweenToday(startDate));
    String res = datesProcessor.inDays();
    int yearDiff = 0;
    if (yearKnown) {
      int currentYear = int.parse(DateFormat("yyyy").format(DateTime.now()));
      int eventYear = int.parse(DateFormat("yyyy").format(startDate));
      // * если дата в этом году прошла - прибавить 1 к "исполняется"
      String checkDateMMdd = (DateFormat("MM-dd").format(startDate));
      String checkDateyyyyMMdd = currentYear.toString() + "-" + checkDateMMdd;
      DateTime checkDate = DateTime.parse(checkDateyyyyMMdd);

      if (datesProcessor.daysBetweenToday() == -1) {
        yearDiff = currentYear - eventYear;
      } else if (checkDate.isBefore(DateTime.now())) {
        yearDiff = currentYear - eventYear + 1;
      } else {
        yearDiff = currentYear - eventYear;
      }

      res += ", исполняется $yearDiff ${datesProcessor.inYears(yearDiff)}";
      //+ " ${DateFormat("yyyy-MM-dd").format(startDate)}"
    }
    return res;
  }

  Event copyWith({
    int? eventKind,
    String? personName,
    bool? yearKnown,
    DateTime? startDate,
    bool? systemNotifications,
    bool? notifyToday,
    bool? notifyTomorrow,
    bool? notify3Days,
    bool? notifyWeek,
  }) {
    return Event(
      eventKind: eventKind ?? this.eventKind,
      personName: personName ?? this.personName,
      yearKnown: yearKnown ?? this.yearKnown,
      startDate: startDate ?? this.startDate,
      systemNotifications: systemNotifications ?? this.systemNotifications,
      notifyToday: notifyToday ?? this.notifyToday,
      notifyTomorrow: notifyTomorrow ?? this.notifyTomorrow,
      notify3Days: notify3Days ?? this.notify3Days,
      notifyWeek: notifyWeek ?? this.notifyWeek,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventKind': eventKind,
      'personName': personName,
      'yearKnown': yearKnown,
      'startDate': startDate.millisecondsSinceEpoch,
      'systemNotifications': systemNotifications,
      'notifyToday': notifyToday,
      'notifyTomorrow': notifyTomorrow,
      'notify3Days': notify3Days,
      'notifyWeek': notifyWeek,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      eventKind: map['eventKind'],
      personName: map['personName'],
      yearKnown: map['yearKnown'],
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      systemNotifications: map['systemNotifications'],
      notifyToday: map['notifyToday'],
      notifyTomorrow: map['notifyTomorrow'],
      notify3Days: map['notify3Days'],
      notifyWeek: map['notifyWeek'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Event(eventKind: $eventKind, personName: $personName, yearKnown: $yearKnown, startDate: $startDate, systemNotifications: $systemNotifications, notifyToday: $notifyToday, notifyTomorrow: $notifyTomorrow, notify3Days: $notify3Days, notifyWeek: $notifyWeek)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Event &&
        other.eventKind == eventKind &&
        other.personName == personName &&
        other.yearKnown == yearKnown &&
        other.startDate == startDate &&
        other.systemNotifications == systemNotifications &&
        other.notifyToday == notifyToday &&
        other.notifyTomorrow == notifyTomorrow &&
        other.notify3Days == notify3Days &&
        other.notifyWeek == notifyWeek;
  }

  @override
  int get hashCode {
    return eventKind.hashCode ^
        personName.hashCode ^
        yearKnown.hashCode ^
        startDate.hashCode ^
        systemNotifications.hashCode ^
        notifyToday.hashCode ^
        notifyTomorrow.hashCode ^
        notify3Days.hashCode ^
        notifyWeek.hashCode;
  }
}
