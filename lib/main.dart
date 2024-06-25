import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:agence_transfert/controllers/MenuAppController.dart';
import 'package:agence_transfert/login/agentDeTransfert/login_agent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login/admin/login_admin.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flex_color_scheme/flex_color_scheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCsJLnoa8ifarcLpikInwUrhTfNSAfx0E8",
      authDomain: "gestion-de-transfert-67fca.firebaseapp.com",
      projectId: "gestion-de-transfert-67fca",
      storageBucket: "gestion-de-transfert-67fca.appspot.com",
      messagingSenderId: "511580167896",
      appId: "1:511580167896:web:14e91fa02573973e18c1ad",
      measurementId: "G-NTXF224MMZ"
    ),
  );

  // await Firebase.initializeApp(
  //   options: const FirebaseOptions(
  //       apiKey: "AIzaSyCTlbdtv3NS1cBbsVpBccQAwzKAKFgRhd0",
  //       authDomain: "database-1e0b4.firebaseapp.com",
  //       projectId: "database-1e0b4",
  //       storageBucket: "database-1e0b4.appspot.com",
  //       messagingSenderId: "688151408469",
  //       appId: "1:688151408469:web:2b7a38e18e11faca9bc9dc",
  //       measurementId: "G-QQKERGQRER"),
  // );

  runApp(
    ChangeNotifierProvider(
      create: (context) => MenuAppController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion de transfert de fonds',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Roboto',
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: AppColors.background),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
        ],
        child: LoginAgent(),
      ),
      initialRoute: 'agent',
      routes: {
        'agent': (context) => LoginAgent(), // Route par défaut
        'admin': (context) =>
            LoginAdmin(), // Route pour le module administrateur
      },
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
