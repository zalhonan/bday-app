import 'package:intl/intl.dart';

class DatesProcessor {
  String languageCode;
  DateTime todayDate;
  DateTime inputDate;

  DatesProcessor({
    required this.languageCode,
    required this.todayDate,
    required this.inputDate,
  });

  int daysBetweenToday() {
    // * возвращает кол-во дней между todayDate и inputDate в этом году
    // * или в следующем, если дата уже прошла

    // * приводим inputDate к формату "MM-DD"
    String mmdd = DateFormat("MM-dd").format(inputDate);

    // * обработка даты сегодня. Возвращаем -1
    if (mmdd == DateFormat("MM-dd").format(todayDate)) {
      return -1;
    }

    // * Узнаём текущий год
    String currentYear = DateFormat("yyyy").format(todayDate);

    // * присоединяем текущий год к inputDate в формате mmdd
    String yyyymmdd = currentYear + "-" + mmdd;

    // * если дата меньше сегодняшней - заменяем год на следующий
    DateTime modifiedInputDate = DateTime.parse(yyyymmdd);
    if (modifiedInputDate.isBefore(todayDate)) {
      int nextYear = int.parse(currentYear) + 1;
      yyyymmdd = nextYear.toString() + "-" + mmdd;
      modifiedInputDate = DateTime.parse(yyyymmdd);
    }

    return modifiedInputDate.difference(todayDate).inDays;
  }

  String inDays() {
    // * Возвращает дату в формате "Через 15 дней"

    if (languageCode == "ru") {
      return inDaysRu();
    } else if (languageCode == "en") {
      return inDaysEn();
    }
    return inDaysEn();
  }

  String inDaysRu() {
    int inputDay = daysBetweenToday();
    int lastDay = inputDay % 10;

    if (inputDay == -1) {
      return "Сегодня";
    } else if (inputDay == 0) {
      return "Завтра";
    } else if (inputDay == 1) {
      return "Послезавтра";
    }
    // * костыль - коррекия даты "через"
    inputDay += 1;
    if ((inputDay >= 5 && inputDay <= 20) ||
        (inputDay >= 205 && inputDay <= 220) ||
        (inputDay >= 305 && inputDay <= 320)) {
      return "Через $inputDay дней";
    } else if (lastDay >= 2 && lastDay <= 4) {
      return "Через $inputDay дня";
    } else if (lastDay == 1) {
      return "Через $inputDay день";
    } else {
      return "Через $inputDay дней";
    }
  }

// * 2 дня
// * 3 дня
// * 4 дня
// * 5 - 20 дней
//
// * 21 день
// * 22, 23, 24 дня
// * 25 - 30 дней

  String inDaysEn() {
    int inputDay = daysBetweenToday();

    if (inputDay == -1) {
      return "Today";
    } else if (inputDay == 0) {
      return "Tomorrow";
    } else if (inputDay == 1) {
      return "Day after tomorrow";
    }
    // * костыль - коррекия даты "через"
    inputDay += 1;
    return "In $inputDay days";
  }

  String inYears(int yearDiff) {
    // * Возвращает "исполняется" в годах в формате "лет" или "года"

    if (languageCode == "ru") {
      return inYearsRu(yearDiff);
    } else if (languageCode == "en") {
      return inYearsEn(yearDiff);
    }
    return inYearsEn(yearDiff);
  }

  String inYearsEn(int yearDiff) {
    if (yearDiff == 1) {
      return "year";
    } else {
      return "years";
    }
  }

  String inYearsRu(int yearDiff) {
    int year = yearDiff % 10;

    if (yearDiff > 100 && yearDiff % 100 >= 12 && yearDiff % 100 <= 21) {
      return "лет";
    } else if (yearDiff >= 5 && yearDiff <= 20) {
      return "лет";
    } else if (year == 1) {
      return "год";
    } else if (year >= 2 && year <= 4) {
      return "года";
    } else {
      return "лет";
    }
  }

// * 1 год
// * 2, 3, 4 года
// * 5 - 20 - лет
// * 21 года
// *

}
