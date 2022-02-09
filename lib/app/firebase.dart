import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

initConfigurations() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBoScVDKsZP7IX-aHYM5DyNGhRSGR2Qcts",
        authDomain: "lti-pdvexpress.firebaseapp.com",
        projectId: "lti-pdvexpress",
        storageBucket: "lti-pdvexpress.appspot.com",
        messagingSenderId: "561101473089",
        appId: "1:561101473089:web:95b64260abb47f9c484dc0",
        measurementId: "G-VYNJE55LG6"
    ),
  );

  // Get.lazyPut<ThemeController>(() => ThemeController());
}