import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:agence_transfert/screens/main/composants/dialog_agence.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:agence_transfert/constants.dart';
import 'package:agence_transfert/screens/main/composants/header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:agence_transfert/screens/main/composants/dialog_agent.dart'; // Assurez-vous que le chemin d'importation est correct

class GestionAgentsPage extends StatelessWidget {
  // final GlobalKey<DialogAgenceState> dialogKey = GlobalKey<DialogAgenceState>();

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
                        DialogAgent().showCustomDialog(context);
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

                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('agents')
                        .orderBy('id',
                            descending: false) // Tri par ordre croissant
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Erreur : ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      // Création de la liste de rows avec les documents triés
                      List<DataRow> rows =
                          snapshot.data!.docs.map((DocumentSnapshot doc) {
                        Map<String, dynamic> data =
                            doc.data() as Map<String, dynamic>;
                        return DataRow(
                          cells: [
                            DataCell(Text(data['id'].toString())),
                            DataCell(Text(data['nom'] ?? '')),
                            DataCell(Text(data['password'] ?? '')),
                            DataCell(Text(data['phone'] ?? '')),
                          ],
                        );
                      }).toList();

                      return DataTable(
                        border: TableBorder
                            .all(), // Ajouter des bordures autour de tout le tableau
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              'ID',
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .bold), // Rendre l'entête en gras
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'NOM AGENT',
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .bold), // Rendre l'entête en gras
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'PASSWORD',
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .bold), // Rendre l'entête en gras
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'TELEPHONE',
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .bold), // Rendre l'entête en gras
                            ),
                          ),
                        ],
                        rows: rows,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
