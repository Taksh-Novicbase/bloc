import 'package:flutter/material.dart';
import 'package:my_bloc_app/routes/routes.dart';
import 'package:my_bloc_app/view/home/UI/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Routes.myRoutes,
    );
  }
}
