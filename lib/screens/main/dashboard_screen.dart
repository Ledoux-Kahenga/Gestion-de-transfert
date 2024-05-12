import 'package:flutter/material.dart';
import 'package:agence_transfert/constants.dart';
import 'package:agence_transfert/screens/agence/header.dart'; // Assurez-vous que le chemin d'importation est correct

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Calculer la hauteur en fonction de la hauteur totale de l'écran
        double screenHeight = constraints.maxHeight;
        double dashboardHeight = screenHeight * (5 / 6); // 5/6 de la hauteur de l'écran

        return Container(
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: Header()), // Placez Header() au début de la Column
                SizedBox(height: defaultPadding),
                Text('bonjour'),
                SizedBox(height: defaultPadding),
                Text('bonjour'),
                // Ajoutez d'autres widgets ici
              ],
            ),
          ),
        );
      },
    );
  }
}