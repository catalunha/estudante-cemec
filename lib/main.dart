import 'package:async_redux/async_redux.dart';
import 'package:estudante/app_state.dart';
import 'package:estudante/routes.dart';
import 'package:estudante/theme/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

late Store<AppState> store;
final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Intl.defaultLocale = 'pt_BR';
  // initializeDateFormatting();
  store = Store<AppState>(initialState: AppState.initialState());
  NavigateAction.setNavigatorKey(navigatorKey);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'CEMEC Estudante',
        theme: ThemeData(
          primaryColor: AppColors.primary,
          primarySwatch: AppColors.swatch,
        ),
        navigatorKey: navigatorKey,
        routes: Routes.routes,
        initialRoute: '/',
      ),
    );
  }
}
