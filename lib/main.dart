import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:agence_transfert/controllers/MenuAppController.dart';
import 'package:agence_transfert/login/agentDeTransfert/login_agent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login/admin/login_admin.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:agence_transfert/database/firebase_options.dart' as firebase_options;

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
        scaffoldBackgroundColor: AppColors.background
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
        ],
        child: LoginAgent(),
        // child: DashboardScreen(),
      ),

  //      initialRoute: '/',
  // routes: {
  //   '/': (context) => LoginAdmin(), // Route par défaut
  //   '/admin': (context) => AdminModule(), // Route pour le module administrateur
  //   '/agent': (context) => AgentModule(), // Route pour le module agent de transfert
  // },

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
