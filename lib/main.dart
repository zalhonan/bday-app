import 'package:flutter/material.dart';
import './screens/main_page.dart';
import 'package:get/get.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

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
