import 'package:flutter/material.dart';
import 'package:water_tracker/core/error/routes/my_router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: MyRouter().router, //go-router
    );
  }
}
