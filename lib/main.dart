import 'package:flutter/material.dart';
import 'package:flutter_api/showpokemonmodel.dart';
import 'package:flutter_api/showusermodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Api Learning',
      home: ShowProduct(),
    );
  }
}
