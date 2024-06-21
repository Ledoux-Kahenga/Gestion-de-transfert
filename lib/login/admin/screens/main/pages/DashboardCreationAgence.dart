import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:agence_transfert/login/admin/screens/main/composants/agenceDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:agence_transfert/constants.dart';
import 'package:agence_transfert/login/admin/screens/main/composants/header_home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:agence_transfert/login/admin/screens/main/composants/dialog_agence.dart';
import 'package:data_table_2/data_table_2.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController villeController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  InputDecoration _getInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    );
  }

  @override
  void dispose() {
    provinceController.dispose();
    villeController.dispose();
    adresseController.dispose();
    super.dispose();
  }

  void _showAgenceDetails(Map<String, dynamic> agenceData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Détails de l\'agence'),
          content: Container(
            width: 600, // Adjust the dialog width according to your needs
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: idController
                    ..text = agenceData['idAgence'].toString(),
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Id',
                  ),
                ),
                TextFormField(
                  controller: provinceController..text = agenceData['province'],
                  decoration: InputDecoration(
                    labelText: 'Province',
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: villeController..text = agenceData['ville'],
                  decoration: InputDecoration(
                    labelText: 'Ville',
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: adresseController..text = agenceData['adresse'],
                  decoration: InputDecoration(
                    labelText: 'Adresse',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
            TextButton(
              onPressed: () async {
                // Retrieve the agence ID from the text field
                String? idAgence = idController.text;
                if (idAgence.isNotEmpty) {
                  try {
                    // Vérifie si le document existe déjà
                    DocumentReference docRef = FirebaseFirestore.instance
                        .collection('agences')
                        .doc(idAgence);
                    DocumentSnapshot docSnap = await docRef.get();

                    if (!docSnap.exists) {
                      // Le document n'existe pas, vous pouvez donc le créer sans risque de doublon
                      await FirebaseFirestore.instance
                          .collection('agences')
                          .doc(idAgence)
                          .set({
                        'province': provinceController.text,
                        'ville': villeController.text,
                        'adresse': adresseController.text,
                      });
                    } else {
                      // Le document existe, vous pouvez le mettre à jour sans risque de doublon
                      await FirebaseFirestore.instance
                          .collection('agences')
                          .doc(idAgence)
                          .update({
                        'province': provinceController.text,
                        'ville': villeController.text,
                        'adresse': adresseController.text,
                      });
                    }

                    print("Agence details updated successfully.");
                  } catch (e) {
                    print("Failed to update agence details: $e");
                  }
                }
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('Sauvegarder'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double screenHeight = constraints.maxHeight;
        double dashboardHeight = screenHeight;
        return Container(
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 8, top: 8, right: 8),
                  child: Header(),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors
                          .white, // Remplacez ceci par la couleur que vous souhaitez
                      // Optionnel : pour donner des coins arrondis
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('agences')
                          .orderBy('dateCreationAgence', descending: false)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Erreur : ${snapshot.error}');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center();
                        }

                        List<Map<String, dynamic>> rowsData;

                        if (snapshot.hasData) {
                          rowsData = snapshot.data!.docs.map((doc) {
                            return {
                              // 'id': int.parse(doc.id), // Convertir l'ID en entier
                              'dateCreationAgence': doc.get('dateCreationAgence'),
                              // Utilisez doc.id pour obtenir l'ID du document
                              'nom': doc.get('nom'),
                              // Corrigez le nom du champ ici
                              'ville': doc.get('ville'),
                              'province': doc.get('province'),
                              'adresse': doc.get('adresse'),
                              'agentName': doc.get('agentName')
                            };
                          }).toList();
                        } else {
                          rowsData = [];
                        }

                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: dashboardHeight,
                            ),

                            // child: Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            child: DataTable2(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.background1),
                              ),
                              // minWidth: 600,
                              headingRowColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => AppColors.customColor),
                              // horizontalMargin: 12,
                              columns: const <DataColumn>[
                                DataColumn2(
                                  label: Center(
                                    child: Text('ID',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  //  size: ColumnSize.S,
                                  fixedWidth: 44,
                                ),
                                DataColumn2(
                                    label: Text('NOM DE L\' AGENCE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    size: ColumnSize.L),
                                DataColumn2(
                                    label: Text('PROVINCE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    size: ColumnSize.M),
                                DataColumn2(
                                    label: Text('VILLE OU AUTRE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    size: ColumnSize.M),
                                    DataColumn2(
                                    label: Text('AGENT DE TRANSFERT',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    size: ColumnSize.L),
                                DataColumn2(
                                    label: Text('ADRESSE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    size: ColumnSize.M),
                                DataColumn2(
                                  label: Center(
                                    child: Text('OPTION',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  fixedWidth: 80,
                                ),
                              ],
                              rows: List.generate(
                                  rowsData.length,
                                  (index) => DataRow(

                                          // color: MaterialStateColor.resolveWith((states) => AppColors.background),
                                          cells: [
                                            DataCell(Center(
                                                child: Text(
                                                    (index + 1).toString()))),
                                            DataCell(
                                                Text(rowsData[index]['nom'])),
                                            DataCell(Text(
                                                rowsData[index]['province'])),
                                            DataCell(
                                                Text(rowsData[index]['ville'])),
                                                DataCell(
                                                Text(rowsData[index]['agentName'])),
                                            DataCell(Text(
                                                rowsData[index]['adresse'])),
                                            DataCell(
                                              Center(
                                                child: IconButton(
                                                  icon: Center(
                                                    child: Icon(Icons.more_vert,
                                                        color: Colors.grey),
                                                  ),
                                                  onPressed: () {
                                                   _showAgenceDetails(rowsData[index]);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ])).toList(),
                            ),
                          ),
                        );
                      },
                    ),
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
