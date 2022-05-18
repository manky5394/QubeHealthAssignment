import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qube_health_assignment/di/binding.dart';
import 'package:qube_health_assignment/ui/date_picker_ui.dart';
import 'package:qube_health_assignment/ui/feelings_history/page/user_feelings_history.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  HttpOverrides.global = MyHttpOverrides();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Your Feelings',
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.white,
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(
                fontFamily: "SF-Pro-Rounded", decoration: TextDecoration.none),
          )),
      getPages: [
        GetPage(
            name: "/app_entry_screen",
            page: () => const DatePickerUi(), //const UserFeelingsHistory(),
            binding: Binding()),
        GetPage(
            name: "/app_home_screen",
            page: () =>
                const UserFeelingsHistory(), //const UserFeelingsHistory(),
            binding: Binding())
      ],
      initialRoute: "/app_entry_screen",
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
