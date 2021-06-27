import 'package:flutter/material.dart';

const String kHiveBoxName = "eventsCardsApp2021";
const String kHiveMainKey = "events";

const double kCardHeadlineFontSize = 24;
const double kCardSubtextFontSize = 14;

const double kFontSizeHeadline5 = 24;
const double kFontSizeHeadline6 = 20;
const double kFontSizeSubtitle1 = 16;

Color? kColorAccent = Colors.green[900];
Color? kColorAccentRed = Colors.redAccent;

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year - 100, kNow.month, kNow.day);
final kLastDay = DateTime(kNow.year + 100, kNow.month + 3, kNow.day);

// * 0 birthday,
// * 1 wedding_anniversary,
// * 2 annual_meeting,
// * 3 rememberance_day,
// * 4 anniversary,

const Map<int, String> kEventEmoji = {
  -1: "🌍",
  0: "🍰",
  1: "💍",
  2: "🎉",
  3: "🕯",
  4: "📋",
};

const Map<int, String> kEventName = {
  -1: "Все",
  0: "День рождения",
  1: "Годовщина свадьбы",
  2: "Ежегодная встреча",
  3: "День памяти",
  4: "Годовщина",
};

const Map<int, String> kEventNameShort = {
  -1: "Все",
  0: "Рождения",
  1: "Свадьбы",
  2: "Встречи",
  3: "Память",
  4: "Годовщины",
};

const Map<int, String> kMonthName = {
  1: "Января",
  2: "Февраля",
  3: "Марта",
  4: "Апреля",
  5: "Мая",
  6: "Июня",
  7: "Июля",
  8: "Августа",
  9: "Сентября",
  10: "Октября",
  11: "Ноября",
  12: "Декабря",
};

const Map<int, String> kReminders = {
  0: "В день события",
  1: "За 1 день",
  2: "За 3 дня",
  3: "За неделю",
};
