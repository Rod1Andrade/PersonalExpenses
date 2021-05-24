import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(PersonalExpanseApp());

/// Entry Point
///
/// @author Rodrigo Andrade
/// @since 20/05/2021
class PersonalExpanseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData.light(),
    );
  }
}
