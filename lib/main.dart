import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pdvexpress/app/app_module.dart';
import 'package:pdvexpress/app/firebase.dart';
import 'package:pdvexpress/app_widget.dart';

void main() {
  initConfigurations();

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}