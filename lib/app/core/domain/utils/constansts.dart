import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final fireInstance = FirebaseAuth.instance;

final googleInstance = GoogleSignIn();

final storeInstance = FirebaseFirestore.instance;

const backgroundColor = Color.fromARGB(255, 31, 31, 31);

const primaryColor = Color.fromARGB(255, 31, 31, 31);
const secondaryColor = Color.fromARGB(255, 243, 130, 33);
const successColor = Color.fromARGB(255, 45, 211, 111);
const successColorAcent = Color.fromARGB(200, 45, 211, 111);
const dangerColor = Color.fromARGB(255, 235, 68, 90);
const dangerColorAcent = Color.fromARGB(200, 235, 68, 90);
const blueColor = Color.fromARGB(255, 0, 102, 153);


const lightColor = Color.fromARGB(255, 244, 245, 248);
const darkColor = Color.fromARGB(255, 244, 245, 248);

Map<int, Color> _color = {
  50: const Color.fromRGBO(24, 25, 32, .1),
  100: const Color.fromRGBO(24, 25, 32, .2),
  200: const Color.fromRGBO(24, 25, 32, .3),
  300: const Color.fromRGBO(24, 25, 32, .4),
  400: const Color.fromRGBO(24, 25, 32, .5),
  500: const Color.fromRGBO(24, 25, 32, .6),
  600: const Color.fromRGBO(24, 25, 32, .7),
  700: const Color.fromRGBO(24, 25, 32, .8),
  800: const Color.fromRGBO(24, 25, 32, .9),
  900: const Color.fromRGBO(24, 25, 32, 1),
};
MaterialColor darkThemeBackgroundMaterial = MaterialColor(0xFF181920, _color);

const darkThemeBackground = Color.fromARGB(255, 5, 5, 12);
const darkThemeTitle = Color.fromARGB(255, 212,211,216);
const darkThemeSubtitle = Color.fromARGB(255, 78, 80, 86);
const darkThemeInputs = Color.fromARGB(255, 37, 42, 52);
const darkThemeCta = Color.fromARGB(255, 85, 104, 254);
const darkThemeSecondary = Color.fromARGB(255, 81, 90, 167);