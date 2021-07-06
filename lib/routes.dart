import 'package:flutter/material.dart';
import 'package:estudante/home/home_page_connector.dart';
import 'package:estudante/login/login_connector.dart';
import 'package:estudante/splash/splash_connector.dart';

class Routes {
  static final routes = {
    '/': (BuildContext context) => SplashConnector(),
    '/login': (BuildContext context) => LoginConnector(),
    '/home': (BuildContext context) => HomePageConnector(),
  };
}
