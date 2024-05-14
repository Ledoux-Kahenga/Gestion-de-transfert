import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:agence_transfert/constants.dart';
import 'package:agence_transfert/screens/main/composants/header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:agence_transfert/screens/main/composants/dialog_agence.dart'; // Assurez-vous que le chemin d'importation est correct

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Calculer la hauteur en fonction de la hauteur totale de l'écran
        double screenHeight = constraints.maxHeight;
        double dashboardHeight =
            screenHeight * (5 / 6); // 5/6 de la hauteur de l'écran
        return Container(
          child: Scaffold(
            body: Column(
              children: [
                Container(
                    child: Header()), // Placez Header() au début de la Column
                SizedBox(height: defaultPadding),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 16),
                    width: 150, // Spécifiez la largeur souhaitée
                    child: ElevatedButton(
                      onPressed: () {
                        // showCustomDialog(context);
                        DialogAgence().showCustomDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // Cela centre les enfants dans le Row
                        children: [
                          SvgPicture.asset(
                            'assets/icons/add.svg',
                            width: 18, // Ajustez la largeur de l'icône ici
                            height: 18,
                            color: AppColors
                                .backgroundWhite, // Ajustez la hauteur de l'icône ici
                          ),
                          const Text(
                            AppTexts.add,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: defaultPadding),
                // Text('bonjour'),
                // Ajoutez d'autres widgets ici
              ],
            ),
          ),
        );
      },
    );
  }
}
