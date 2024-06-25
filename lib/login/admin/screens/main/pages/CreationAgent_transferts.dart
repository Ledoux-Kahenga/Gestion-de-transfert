import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:agence_transfert/login/admin/screens/main/composants/header_agent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:agence_transfert/constants.dart';
import 'package:agence_transfert/login/admin/screens/main/composants/header_home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:agence_transfert/login/admin/screens/main/composants/dialog_agence.dart';
import 'package:data_table_2/data_table_2.dart';

class GestionAgentsPage extends StatelessWidget {
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
                  margin: EdgeInsets.only(left: 2, top: 2, right: 2),
                  child: HeaderAgent(),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('agents')
                          .orderBy('dateCreationAgent', descending: false)
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
                              // 'id': doc.get('id'),
                              // Utilisez doc.id pour obtenir l'ID du document
                              'dateCreationAgent': doc.get('dateCreationAgent'),
                              'nom': doc.get('nom'),
                              // Corrigez le nom du champ ici
                              'password': doc.get('password'),
                              'agenceNom': doc.get('agenceNom'),
                              'contact': doc.get('contact'),
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
                                    fixedWidth: 45,
                                  ),
                                  DataColumn2(
                                      label: Text('NOM DE L\' AGENT',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      size: ColumnSize.M),
                                  DataColumn2(
                                      label: Text('MOT DE PASSE',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      size: ColumnSize.M),
                                  // DataColumn2(
                                  //     label:  Text(
                                  //           'AGENCE',
                                  //           style: TextStyle(
                                  //               fontWeight: FontWeight.bold)),
                                  //     size: ColumnSize.L),
                                  DataColumn2(
                                      label: Text('AGENCE DE TRANSFERT',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      size: ColumnSize.M),
                                  DataColumn2(
                                      label: Text('CONTACT',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      size: ColumnSize.M),
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
                                                  rowsData[index]['password'])),
                                              DataCell(Text(rowsData[index]
                                                  ['agenceNom'])),
                                              DataCell(Text(
                                                  rowsData[index]['contact'])),
                                            ])),
                              ),
                            ));
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
