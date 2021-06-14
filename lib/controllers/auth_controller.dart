import 'package:get/get.dart';

class AuthController extends GetxController {
  var isAuthorized = false.obs;

  login() => isAuthorized.value = true;

  logout() => isAuthorized.value = false;

  var isAdmin = false.obs;

  makeAdmin() => isAdmin.value = true;

  unmakeAdmin() => isAdmin.value = false;
}
