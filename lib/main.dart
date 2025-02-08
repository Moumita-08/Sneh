import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' as flutter_gen;
import 'package:myapp/l10n/l10n.dart' as myapp_l10n;
import 'package:myapp/splash.dart';



void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
      ),
      supportedLocales: flutter_gen.AppLocalizations.supportedLocales,
      localizationsDelegates: flutter_gen.AppLocalizations.localizationsDelegates,
      home: const Splashscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(96, 149, 145, 100), // Top color
            Color.fromRGBO(54, 84, 81, 100),
            Color.fromRGBO(36, 60, 58, 100) // Bottom color
          ],
          stops: [
            0.4,  // Red covers the first 50%
            0.8,  // Blue covers 30% (from 50% to 80%)
            1.0,  // Green covers the last 20% (from 80% to 100%)
          ],
        ),
      ),
      child: child, // Wrap the actual page content
    );
  }
}