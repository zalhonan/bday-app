import 'package:http/http.dart' as http;
import '../services/constants.dart';
import 'dart:convert';

class AsyncRepository {
  // * клиент как переменная - передаём в конструктор для удобства мокирования
  http.Client client;

  AsyncRepository({
    required this.client,
  });

  // * отправка JSONа c событиями на сервер
  Future<String> sendEventsToServer({
    required String token,
    required String language,
    required int timezone,
    required String events,
  }) async {
    String url = kBackendUrl + "events";

    Map<String, String> data = {
      "token": token,
      "language": language,
      "timezone": timezone.toString(),
      "events": events,
    };

    var body = json.encode(data);
    var headers = {"Content-Type": "application/json"};

    var response =
        await client.post(Uri.parse(url), body: body, headers: headers);

    if (response.statusCode != 200) {
      // TODO: убрать отладочный принт
      print(jsonDecode(response.body));
      return "Error";
    }

    return "OK";
  }
}
