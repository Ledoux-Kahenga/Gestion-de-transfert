import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:agence_transfert/constants.dart';
import 'package:agence_transfert/screens/main/composants/header_home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:agence_transfert/screens/main/composants/dialog_agence.dart';
import 'package:data_table_2/data_table_2.dart';

class DashboardScreen extends StatelessWidget {

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
                          .orderBy('idAgence', descending: false)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Erreur : ${snapshot.error}');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        List<Map<String, dynamic>> rowsData;

                        if (snapshot.hasData) {
                          rowsData = snapshot.data!.docs.map((doc) {
                            return {
                              // 'id': int.parse(doc.id), // Convertir l'ID en entier
                              'idAgence': doc.get('idAgence'),
                              // Utilisez doc.id pour obtenir l'ID du document
                              'nom': doc.get('nom'),
                              // Corrigez le nom du champ ici
                              'ville': doc.get('ville'),
                              'province': doc.get('province'),
                              'adresse': doc.get('adresse')
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
                                    label: Text('NOM DE L\' AGENCE',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                  
                                    size: ColumnSize.M),
                                DataColumn2(
                                    label:
                                      Text('PROVINCE',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    
                                    size: ColumnSize.M),
                                DataColumn2(
                                    label:  Text(
                                          'VILLE / TERRITOIRE / VILLAGE',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    size: ColumnSize.L),
                                DataColumn2(
                                    label:  Text('ADRESSE DE L\'AGENCE',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    size: ColumnSize.M),
                              ],
                              rows: rowsData
                                  .map((row) => DataRow(

                                          // color: MaterialStateColor.resolveWith((states) => AppColors.background),
                                          cells: [
                                            DataCell(Center(
                                                child: Text(
                                                    row['idAgence'].toString()))),
                                            DataCell(Text(row['nom'])),
                                            DataCell(Text(row['province'])),
                                            DataCell(Text(row['ville'])),
                                            DataCell(Text(row['adresse']))
                                          ]))
                                  .toList(),
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
