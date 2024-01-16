import 'package:flutter/material.dart';
import 'package:tennis_court_agend/Pages/Agend/agend.dart';
import 'package:tennis_court_agend/Pages/Home/home.dart';
import 'package:tennis_court_agend/Pages/Initial/initial.dart';

abstract class Routes {
  static Map<String, WidgetBuilder> routes = {
    HomePage.routeName: (context) => const HomePage(),
    InitialPage.routeName: (context) => const InitialPage(),
    ReserverCourt.routeName: (context) => const ReserverCourt(),
  };
}
