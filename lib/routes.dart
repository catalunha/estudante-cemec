import 'package:estudante/module/controller/module_connector.dart';
import 'package:estudante/resource/controller/resource_connector.dart';
import 'package:estudante/situation/controller/situation_connector.dart';
import 'package:flutter/material.dart';
import 'package:estudante/home/home_page_connector.dart';
import 'package:estudante/login/login_connector.dart';
import 'package:estudante/splash/splash_connector.dart';

class Routes {
  static final routes = {
    '/': (BuildContext context) => SplashConnector(),
    '/login': (BuildContext context) => LoginConnector(),
    '/home': (BuildContext context) => HomePageConnector(),
    '/module': (BuildContext context) => ModuleConnector(
          courseId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/resource': (BuildContext context) => ResourceConnector(
          moduleId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/situation': (BuildContext context) => SituationConnector(
          moduleId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
  };
}
