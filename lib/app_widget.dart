import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter_localizations/flutter_localizations.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('pt', 'BR')
      ],
      builder: asuka.builder,
      navigatorObservers: [ asuka.asukaHeroController ],
      debugShowCheckedModeBanner: false,
      title: 'Albuquerque Hortifruti',
      theme: ThemeData(primarySwatch: darkThemeBackgroundMaterial),
      initialRoute: Modular.initialRoute,
    ).modular();
  }
}
