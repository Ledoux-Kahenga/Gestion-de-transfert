import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
body: Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/bg1.jpg'), // Remplacez par le chemin de votre image
      fit: BoxFit.cover, // Ajuste la façon dont l'image couvre le widget
    ),
  ),
  child: Center(
    child: Column(
      
      mainAxisAlignment: MainAxisAlignment.center, // Adjust this to push the text to the top
      children: <Widget>[
        SizedBox(height: 50),

        RichText(
          text: TextSpan(
            text: 'AGENCE ',
            style: TextStyle(
              fontSize: 30, // Taille de la police
              fontWeight: FontWeight.bold, // En gras
              color: Colors.black, // Couleur du texte "AGENCE"
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'BAUDOUIN',
                style: TextStyle(
                  fontSize: 30, // Taille de la police
                  fontWeight: FontWeight.bold, // En gras
                  color: Colors.blue, // Couleur du texte "BAUDOIUN"
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 60), 

        RichText(
          text: TextSpan(
            text: 'Admin ',
            style: TextStyle(
              fontSize: 34, // Taille de la police
              fontWeight: FontWeight.bold, // En gras
              color: Colors.white, // Couleur du texte "AGENCE"
            ),
          ),
           ),
           SizedBox(height: 20), 

        // Other widgets like TextFields and the login button go here
         Container(
        width: 300, // Largeur du Container
        height: 50, // Hauteur du Container
        decoration: BoxDecoration(
          color: Colors.white, // Couleur de fond du Container
          borderRadius: BorderRadius.circular(4), // Arrondir les coins
        ),
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.blue), // Style du label
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 158, 158, 158)), // Bordure du TextField
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue), // Bordure lorsqu'il est sélectionné
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
      ),
      SizedBox(height: 20), // Espacement entre les éléments
      Container(
        width: 300, // Largeur du Container
        height: 50, // Hauteur du Container
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Mot de passe',
            labelStyle: TextStyle(color: Colors.blue),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
      ),
      SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          // Votre logique ici
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.blue, // Couleur de fond du bouton
          onPrimary: Colors.white, // Couleur du texte
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Arrondir les coins du bouton
          ),
          minimumSize: Size(200, 50), // Taille minimale du bouton
        ),
        child: Text('Se connecter'),
      ),
      SizedBox(height: 200)
      ],
    ),
  ),
),

  );
  
  }
}