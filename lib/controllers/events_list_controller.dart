import 'package:get/get.dart';

class EventsListController extends GetxController {
  var filter = 0.obs;

  setFilter(int newFilter) => filter.value = newFilter;
}
