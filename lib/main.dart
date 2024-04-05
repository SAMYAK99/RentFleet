import 'package:flutter/material.dart';

import 'Pages/Homepage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2F2E33)),
        useMaterial3: true,
        fontFamily: 'Figtree',
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
