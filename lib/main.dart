import 'package:agence_transfert/controllers/MenuAppController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login/admin/login_admin.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MenuAppController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion de transfert de fonds',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFf8fcff)
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
        ],
        child: LoginAdmin(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoginAdmin());
  }
}
