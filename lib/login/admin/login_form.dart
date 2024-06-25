import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:agence_transfert/configurations/constants/utils.dart';
import 'package:agence_transfert/login/admin/screens/main/main_screen.dart';
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
    // Récupérer les valeurs des champs de formulaire
    String username = usernameController.text;
    String password = passwordController.text;

    try {
      UserCredential userCredential =
          await widget.auth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );

      if (userCredential.user != null) {
        if (isUserAdmin(userCredential.user!)) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Vous n\'êtes pas autorisé en tant qu\'administrateur')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Identifiants incorrects')),
        );
      }
    } catch (e) {
      String errorMessage =
          'Une erreur s\'est produite lors de l\'authentification';
      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? errorMessage;

        // Exceptions spécifiques de Firebase Auth
        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'Adresse e-mail invalide';
            break;
          case 'user-disabled':
            errorMessage = 'Compte utilisateur désactivé';
            break;
          case 'user-not-found':
            errorMessage = 'Utilisateur introuvable';
            break;
          case 'wrong-password':
            errorMessage = 'Mot de passe incorrect';
            break;
          // Ajoutez d'autres exceptions Firebase Auth ici selon vos besoins
          default:
            // Utilisez le message d'erreur par défaut si le code d'erreur n'est pas géré
            errorMessage = e.message ?? errorMessage;
            break;
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  bool isUserAdmin(User user) {

    String adminUID ='2mHh02hYsQeY3qYGp0ryFCpfvWx2'; 
        // E-mail : admin@gmail.com
        // password : 000000

    return user.uid == adminUID;

  }

  // void _doLogin(BuildContext context) {
  //   if (isUserAdmin(null)) {
  //     // Simulons un utilisateur qui serait considéré comme un administrateur
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => MainScreen()),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //           content:
  //               Text('Vous n\'êtes pas autorisé en tant qu\'administrateur')),
  //     );
  //   }
  // }

  // bool isUserAdmin(User? user) {
  //   // Cette méthode peut être modifiée pour toujours retourner vrai ou faux selon votre besoin de simulation
  //   // Par exemple, pour simuler un utilisateur administrateur, vous pouvez simplement retourner vrai :
  //   return true; // Ou false, selon le cas de test que vous souhaitez simuler
  // }

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
      'Admin',
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
