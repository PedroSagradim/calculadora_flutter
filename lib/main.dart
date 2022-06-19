import 'package:flutter/material.dart';
import 'homeScreen.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/': (context) => HomeScreen(),
    '/home': (context) => HomeScreen(),
  },
));