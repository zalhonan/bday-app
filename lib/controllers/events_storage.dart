import 'package:get/get.dart';

import '../models/event.dart';

class EventsStorage extends GetxController {
  var eventsList = [].obs;

  setEvents(List<Event> newEventsList) => eventsList.value = newEventsList;
}
