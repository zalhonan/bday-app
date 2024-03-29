import 'package:events/services/constants.dart';
import 'package:flutter/material.dart';
import './screens/main_page.dart';
import 'package:get/get.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  // * инициализация и открытие бокса
  await Hive.initFlutter();
  await Hive.openBox(kHiveBoxName);

  // * инициализация сервисов Fiebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // * запуск
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ru'),
        const Locale('en'),
      ],
      locale: Locale.fromSubtags(languageCode: 'ru'),
      debugShowCheckedModeBanner: false,
      title: 'Events reminder & cards',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Noto",
      ),
      home: MainPage(),
    );
  }
}
