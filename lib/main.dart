import 'package:flutter/material.dart';
import 'affichageMessages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forum',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ListeMessageHomePage(title: 'Forum | Les messages'),
      debugShowCheckedModeBanner: false,
    );
  }
}
