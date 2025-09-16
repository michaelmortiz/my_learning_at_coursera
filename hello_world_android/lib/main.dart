import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My first App with Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Coursera'),
        ),
        body: Center(
          child: const Text('Hello World'),
        ),
      ),
    );
  }
}
