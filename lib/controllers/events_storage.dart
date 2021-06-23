import 'package:get/get.dart';

import '../models/event.dart';

class EventsStorage extends GetxController {
  var eventsList = [].obs;

  var eventIdToEdit = "".obs;

  setEvents(List<Event> newEventsList) => eventsList.value = newEventsList;

  // * добавление + сортировка по дням до события
  addEvent(Event newEvent) {
    eventsList.add(newEvent);
    eventsList.sort((a, b) => a.eventInDays.compareTo(b.eventInDays));
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
  // TODO: сделать

  // * получить список событий по списку ID
  // TODO: сделать

  // * перезаписать элемент по его ID
  editEvent(Event fixedEvent) {
    for (int i = 0; i < eventsList.length; i++) {
      if (eventsList[i].id == fixedEvent.id) {
        eventsList[i] = fixedEvent;
      }
    }
  }

  // * удалить элемент по ID
  deleteElement(String elementId) {
    eventsList.removeWhere((element) => element.id == elementId);
  }
}
