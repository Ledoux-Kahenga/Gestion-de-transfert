import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:agence_transfert/configurations/constants/utils.dart';
import 'package:agence_transfert/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget { // Assuming you want to extend StatelessWidget

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


void _doLogin(BuildContext context) {
  // Récupérer les valeurs des champs de formulaire
  String username = usernameController.text;
  String password = passwordController.text;

  // Simuler une vérification des identifiants
  bool isAuthenticated = true; // Cette valeur devrait être déterminée par une vérification réelle des identifiants

  if (isAuthenticated) {
    // Naviguer vers une nouvelle page si l'utilisateur est authentifié
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  } else {
    // Afficher un message d'erreur
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Identifiants incorrects')),
    );
  }
}


  Widget build(BuildContext context) {
    return Form(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        _getTitle(),
        add24VerticalSpace(),
        _getUsernameField(),
        add16VerticalSpace(),
        _getPasswordField(),
        add16VerticalSpace(),
        _getActionButton()
      ]),
    );
  }

  Widget _getUsernameField() {
    return TextFormField(
      style: const TextStyle(color: Colors.black, fontSize: 16),
      decoration: _getInputDecoration(AppTexts.userName),
    );
  }

  Widget _getTitle() {
    return const Text(
      AppTexts.login,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    );
  }

  Widget _getPasswordField() {
    return TextFormField(
      style: const TextStyle(color: Colors.black, fontSize: 16),
      obscureText: true,
      decoration: _getInputDecoration(AppTexts.password), // Fixed the missing parenthesis
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
    );
  }
}

