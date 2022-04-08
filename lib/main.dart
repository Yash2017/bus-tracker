import 'package:bus_information_viewer/home_page.dart';
import 'package:flutter/material.dart';
import 'package:textfield_search/textfield_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const home_page(),
    );
  }
}
