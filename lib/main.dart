import 'package:chat/constants.dart';
import 'package:chat/features/auth/presentation/views/register_view.dart';
import 'package:chat/features/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgrounColor,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: const RegisterView(),
    );
  }
}
