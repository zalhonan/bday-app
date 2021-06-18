import 'package:get/get.dart';

class AddEventC extends GetxController {
  var eventKind = 0.obs;

  selectKind(int newValue) => eventKind.value = newValue;
}
