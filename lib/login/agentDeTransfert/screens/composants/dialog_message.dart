import 'dart:math';

import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DialogMessage extends StatefulWidget {
  late String agenceNom;
  late String nom;
  late String agenceId;
  late String password;

  DialogMessage(
      {required this.agenceNom,
      required this.nom,
      required this.agenceId,
      required this.password});

  @override
  _DialogMessageState createState() => _DialogMessageState();
}

class _DialogMessageState extends State<DialogMessage> {


  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var newWidth = width - width * .50;
    var newHeight = height > 500.0 ? 500.0 : height;
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      title: Text(
        'AGENCE ${widget.agenceNom.toUpperCase()}',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      content: Container(
        height: newHeight,
        width: newWidth,
        padding:
            const EdgeInsets.only(left: 60, right: 60, top: 40, bottom: 40),
        child: Column(
          children: [
            Container(
              height: 230,
              padding: EdgeInsets.all(32),
              child: Image.asset('assets/images/boxvide.png'),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 70),
            Text("Fonctionnalité en cours de production."),
          ],
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white, // Couleur du texte
            backgroundColor: Colors.red, // Couleur de fond
            padding: EdgeInsets.symmetric(
                horizontal: 16, vertical: 12), // Espacement du texte
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18), // Coins arrondis
            ),
          ),
          child: Text(
            'Fermer',
            style: TextStyle(
              fontSize: 16, // Taille de la police
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
