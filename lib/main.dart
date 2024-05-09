import 'package:flutter/material.dart';
import 'login_page.dart'; // Assurez-vous d'importer le fichier login_page.dart

void main() {
  runApp(const MyApp());
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
      ),
      home: MyHomePage(title: 'Page d\'accueil'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/44.jpg'), // Remplacez par le chemin de votre image
        fit: BoxFit.cover,// Ajuste la façon dont l'image couvre le widget
      ),
    ),
    child: Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: Text('Aller à la page de connexion'),
        ),
      ),
      ),
    );
  }
}