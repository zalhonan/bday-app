import 'dart:math';

import 'package:bday/models/event.dart';

class EventsRandomizer {
  final int eventsAmount;
  final int startYear;
  final int endYear;
  EventsRandomizer({
    required this.eventsAmount,
    required this.startYear,
    required this.endYear,
  });

  List<Event> getEvents() {
    List<Event> res = [];

    var rnd = Random();

    for (var i = 0; i < eventsAmount; i++) {
      res.add(Event(
        eventKind: generateRandomEvent(),
        personName: generateRandomString(rnd.nextInt(10)) +
            " " +
            generateRandomString(rnd.nextInt(10)),
        yearKnown: rnd.nextBool(),
        startDate: DateTime.parse(generateRandomDate()),
        systemNotifications: rnd.nextBool(),
        notifyToday: rnd.nextBool(),
        notifyTomorrow: rnd.nextBool(),
        notify3Days: rnd.nextBool(),
        notifyWeek: rnd.nextBool(),
      ));
    }

    res.add(Event(
      eventKind: generateRandomEvent(),
      personName: "Today Year Ago",
      yearKnown: true,
      startDate: DateTime.now().subtract(const Duration(days: 365)),
      systemNotifications: rnd.nextBool(),
      notifyToday: rnd.nextBool(),
      notifyTomorrow: rnd.nextBool(),
      notify3Days: rnd.nextBool(),
      notifyWeek: rnd.nextBool(),
    ));

    res.add(Event(
      eventKind: generateRandomEvent(),
      personName: "Tomorrow Year Ago",
      yearKnown: true,
      startDate: DateTime.now()
          .subtract(const Duration(days: 365))
          .add(Duration(days: 1)),
      systemNotifications: rnd.nextBool(),
      notifyToday: rnd.nextBool(),
      notifyTomorrow: rnd.nextBool(),
      notify3Days: rnd.nextBool(),
      notifyWeek: rnd.nextBool(),
    ));

    res.add(Event(
      eventKind: generateRandomEvent(),
      personName: "2 days Year Ago",
      yearKnown: true,
      startDate: DateTime.now()
          .subtract(const Duration(days: 365))
          .add(Duration(days: 2)),
      systemNotifications: rnd.nextBool(),
      notifyToday: rnd.nextBool(),
      notifyTomorrow: rnd.nextBool(),
      notify3Days: rnd.nextBool(),
      notifyWeek: rnd.nextBool(),
    ));

    res.add(Event(
      eventKind: generateRandomEvent(),
      personName: "3 days Year Ago",
      yearKnown: true,
      startDate: DateTime.now()
          .subtract(const Duration(days: 365))
          .add(Duration(days: 3)),
      systemNotifications: rnd.nextBool(),
      notifyToday: rnd.nextBool(),
      notifyTomorrow: rnd.nextBool(),
      notify3Days: rnd.nextBool(),
      notifyWeek: rnd.nextBool(),
    ));

    res.add(Event(
      eventKind: generateRandomEvent(),
      personName: "After tomorr. 2 Years Ago",
      yearKnown: true,
      startDate: DateTime.now()
          .subtract(const Duration(days: 365 * 2))
          .add(Duration(days: 1)),
      systemNotifications: rnd.nextBool(),
      notifyToday: rnd.nextBool(),
      notifyTomorrow: rnd.nextBool(),
      notify3Days: rnd.nextBool(),
      notifyWeek: rnd.nextBool(),
    ));

    res.add(Event(
      eventKind: generateRandomEvent(),
      personName: "Today this day",
      yearKnown: true,
      startDate: DateTime.now(),
      systemNotifications: rnd.nextBool(),
      notifyToday: rnd.nextBool(),
      notifyTomorrow: rnd.nextBool(),
      notify3Days: rnd.nextBool(),
      notifyWeek: rnd.nextBool(),
    ));

    return res;
  }

  int generateRandomEvent() {
    var rnd = Random();
    if (rnd.nextBool()) {
      return 0;
    }
    return rnd.nextInt(5);
  }

  String generateRandomDate() {
    var rnd = Random();
    String year = (rnd.nextInt(endYear - startYear) + startYear).toString();
    String month = addZero((rnd.nextInt(12) + 1).toString());
    String day = addZero((rnd.nextInt(27) + 1).toString());
    return year + "-" + month + "-" + day;
  }

  String addZero(String number) {
    if (number.length == 1) {
      number = "0" + number;
    }
    return number;
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    return capitalize(
        List.generate(len + 2, (index) => _chars[r.nextInt(_chars.length)])
            .join()
            .toLowerCase());
  }

  String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }
    return string[0].toUpperCase() + string.substring(1);
  }
}
