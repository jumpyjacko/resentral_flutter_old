import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:resentral_flutter/pages/login.dart';
import 'package:resentral_flutter/pages/timetable.dart';
import 'package:resentral_flutter/pages/announcements.dart';
import 'package:resentral_flutter/pages/full_timetable.dart';
import 'package:resentral_flutter/pages/settings.dart';
import 'package:resentral_flutter/pages/buses.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool firstTime = true;

  Future<bool> isFirstTime() async {
    final SharedPreferences prefs = await _prefs;
    var isFirstTime = prefs.getBool("first_time");
    if (isFirstTime != null && !isFirstTime) {
      prefs.setBool('first_time', false);
      return false;
    } else {
      prefs.setBool('first_time', false);
      return true;
    }
  }

  @override
  void initState() {
    super.initState();

    isFirstTime().then((isFirstTime) {
      firstTime = isFirstTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'reSentral',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(
            Theme.of(context).textTheme.apply(bodyColor: Colors.black)),
        brightness: Brightness.light,
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.grey.shade50,
        colorScheme: ColorScheme.light(
          background: Colors.grey.shade50,
          onBackground: Colors.black,
          primary: Colors.blue.shade600,
          onPrimary: Colors.white,
          secondary: Colors.blue.shade50,
        ),
      ),
      darkTheme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(
            Theme.of(context).textTheme.apply(bodyColor: Colors.white)),
        brightness: Brightness.dark,
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.blueGrey.shade900,
        colorScheme: ColorScheme.dark(
          background: Colors.blueGrey.shade900,
          onBackground: Colors.white,
          primary: Colors.green.shade500,
          onPrimary: Colors.white,
          secondary: Colors.green.shade900,
        ),
      ),
      home: firstTime ? const Login() : const Overlays(),
    );
  }
}

class Overlays extends StatefulWidget {
  const Overlays({Key? key}) : super(key: key);

  @override
  State<Overlays> createState() => _OverlaysState();
}

class _OverlaysState extends State<Overlays> {
  static int selectedIndex = 0;

  final screens = [
    FullTimetable(),
    Announcements(),
    Timetable(),
    Buses(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          height: 56,
          backgroundColor: Theme.of(context).colorScheme.background,
          indicatorColor: Theme.of(context).colorScheme.secondary,
        ),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) =>
              setState(() => selectedIndex = index),
          animationDuration: const Duration(milliseconds: 500),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.calendar_month),
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Full Timetable',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.announcement),
              icon: Icon(Icons.announcement_outlined),
              label: 'Announcements',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.class_),
              icon: Icon(Icons.class__outlined),
              label: 'Timetable',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.directions_bus),
              icon: Icon(Icons.directions_bus_outlined),
              label: 'Buses',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings_outlined),
              label: 'Timetable',
            ),
          ],
        ),
      ),
    );
  }
}
