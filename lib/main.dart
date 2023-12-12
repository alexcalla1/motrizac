// ignore: unused_import
//import 'dart:ui_web';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:motrizac/PAGE/AlumnoPage.dart';
import 'package:motrizac/PAGE/Informacion.dart';
import 'package:motrizac/PAGE/imc.dart';
import 'package:motrizac/PAGE/listpageAlumnoJSON.dart';
import 'package:motrizac/firebase_options.dart';

import '../LOGIN/formato/screens/auth_screen.dart';
import '../LOGIN/formato/screens/intro_screen.dart';
import 'PAGE/MenuPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Homeapp());
}

class Homeapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 2, 70, 16),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xfff2f9fe),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffeeeeee)),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffeeeeee)),
            borderRadius: BorderRadius.circular(25),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffeeeeee)),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      home: IntroScreen(),
      routes: {
        'intro': (context) => IntroScreen(),
        'home': (context) => ListaPageAlumno(),
        'login': (context) => const AuthScreen(authType: AuthType.login),
        'register': (context) => const AuthScreen(authType: AuthType.register),
        'alumno': (BuildContext context) => AlumnoPage(),
        'listaalumno': (BuildContext context) => ListaPageAlumno(),
        'menu':(context) => MenuApp(),
        'imc':(context) => ImcApp(),
        'informacion':(context) => InformacionApp(),
      },
    );
  }
}
