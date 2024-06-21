import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:agence_transfert/configurations/constants/utils.dart';
import 'package:agence_transfert/login/admin/screens/main/main_screen.dart';
import 'package:agence_transfert/login/agentDeTransfert/screens/main_screen_agent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class LoginForm extends StatefulWidget {
  final FirebaseAuth auth;

  LoginForm({required this.auth});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialisation des contrôleurs ici si nécessaire
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _doLogin(BuildContext context) async {
    String nom = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (nom.isNotEmpty && password.isNotEmpty) {
      _signIn(nom, password);
    } else {
      print('Veuillez remplir tous les champs.');
    }
  }

  Future<void> _signIn(String nom, String password) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('agents')
        .where('nom', isEqualTo: nom)
        .get();
    if (querySnapshot.docs.isEmpty) {
      print('Aucun utilisateur trouvé pour ce nom.');
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erreur de connexion'),
              content: Text('Le nom ou le mot de passe est incorrect.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            );
          });
      return;
    }
    final userDocument = querySnapshot.docs.first;
    final storedPassword = userDocument.data()['password'];
    if (storedPassword == password) {
      
      // Connexion réussie
      final agenceNom = userDocument.data()['agenceNom']; 
      final nom = userDocument.data()['nom']; 
      final agenceId = userDocument.data()['agenceId']; 
      final password = userDocument.data()['password']; 
     
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainScreenAgent(agenceNom: agenceNom, nom: nom, agenceId: agenceId, password: password)));
    } else {
      print('Mot de passe incorrect.');
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erreur de connexion'),
              content: Text('Le mot de passe est incorrect.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            );
          });
    }
  }

  Widget build(BuildContext context) {
    return Form(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        _getTitle(),
        add24VerticalSpace(),
        // _getUsernameField(),
        TextFormField(
          style: const TextStyle(color: Colors.black, fontSize: 16),
          decoration: _getInputDecoration2(AppTexts.userName),
          validator: (value) {
            if (value == null || !EmailValidator.validate(value)) {
              return 'Veuillez entrer une adresse e-mail valide';
            }
            return null;
          },
          controller:
              usernameController, // Lien avec le contrôleur du nom d'utilisateur
        ),
        add16VerticalSpace(),
        // _getPasswordField(),

        TextFormField(
          style: const TextStyle(color: Colors.black, fontSize: 16),
          obscureText: true,
          decoration: _getInputDecoration(AppTexts.password),
          controller:
              passwordController, // Lien avec le contrôleur du mot de passe
        ),

        add16VerticalSpace(),
        _getActionButton()
      ]),
    );
  }

  Widget _getTitle() {
    return const Text(
      "AGENT DE TRANSFERT",
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    );
  }

  Widget _getActionButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: () {
          _doLogin(context);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        child: const Text(
          AppTexts.login,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  InputDecoration _getInputDecoration(String hints) {
    return InputDecoration(
        fillColor: const Color(0xffF6F8FB).withOpacity(0.5),
        filled: true,
        border: const OutlineInputBorder(),
        label: Text(
          hints,
          style: const TextStyle(color: Colors.black87),
        ),
        prefixIcon: Icon(Icons.lock_outline));
  }

  InputDecoration _getInputDecoration2(String hints) {
    return InputDecoration(
        fillColor: const Color(0xffF6F8FB).withOpacity(0.5),
        filled: true,
        border: const OutlineInputBorder(),
        label: Text(
          hints,
          style: const TextStyle(color: Colors.black87),
        ),
        prefixIcon: Icon(Icons.person_outline));
  }
}
