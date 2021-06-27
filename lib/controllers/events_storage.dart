import 'package:get/get.dart';

import '../models/event.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../services/constants.dart';

class EventsStorage extends GetxController {
  var eventsList = [].obs;

  var eventIdToEdit = "".obs;

  var box = Hive.box(kHiveBoxName);

  setEvents(List<Event> newEventsList) => eventsList.value = newEventsList;

  // * ресет списка событий
  resetEvents() {
    eventsList.value = [];
  }

  // * апдейт хранилища в хайве
  updateHive() {
    String jsonString = Event.encode(eventsList.value);
    box.put(kHiveMainKey, jsonString);
  }

  // * добавление + сортировка по дням до события
  addEvent(Event newEvent) {
    eventsList.add(newEvent);
    eventsList.sort((a, b) => a.eventInDays.compareTo(b.eventInDays));
    updateHive();
  }

  // * установка ID элемента для редактирования
  setEventToEdit(String eventId) => eventIdToEdit.value = eventId;

  // * получить элемент по ID
  Event get getEventIdSet {
    for (Event e in eventsList) {
      if (e.id == eventIdToEdit.value) {
        return e;
      }
    }
    throw ("Element not found yo $eventIdToEdit");
  }

  // * получить список ID событий для данного дня
  List<String> getEventsIdsByDay(DateTime day) {
    List<String> res = [];
    for (Event e in eventsList) {
      if (e.startDate.day == day.day && e.startDate.month == day.month) {
        res.add(e.id);
      }
    }
    return res;
  }

  // * получить список событий для данного дня
  List<Event> getEventsByDay(DateTime day) {
    List<Event> res = [];
    for (Event e in eventsList) {
      if (e.startDate.day == day.day && e.startDate.month == day.month) {
        res.add(e);
      }
    }
    return res;
  }

  // * получить список событий по списку ID
  List<Event> getEventsByIds(List<String> eventsIds) {
    List<Event> res = [];
    for (String id in eventsIds) {
      for (Event e in eventsList) {
        if (e.id == id) {
          res.add(e);
        }
      }
    }
    return res;
  }

  // * перезаписать элемент по его ID
  editEvent(Event fixedEvent) {
    for (int i = 0; i < eventsList.length; i++) {
      if (eventsList[i].id == fixedEvent.id) {
        eventsList[i] = fixedEvent;
      }
    }
    updateHive();
  }

  // * удалить элемент по ID
  deleteElement(String elementId) {
    eventsList.removeWhere((element) => element.id == elementId);
    updateHive();
  }
}
