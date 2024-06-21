import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:agence_transfert/login/admin/screens/main/composants/agenceDialog.dart';
import 'package:agence_transfert/login/admin/screens/main/composants/dialog_agent.dart';
import 'package:agence_transfert/login/agentDeTransfert/screens/composants/dialog_envoyer.dart';
import 'package:agence_transfert/login/agentDeTransfert/screens/composants/dialog_recevoir.dart';
import 'package:agence_transfert/login/agentDeTransfert/screens/composants/dialog_transactions.dart';
import 'package:agence_transfert/login/agentDeTransfert/screens/composants/footerAgent.dart';
import 'package:agence_transfert/login/agentDeTransfert/screens/composants/header_home_Agent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:agence_transfert/constants.dart';
import 'package:agence_transfert/login/admin/screens/main/composants/header_home.dart';
import 'package:intl/intl.dart';

class DashboardAgentScreen extends StatefulWidget {
  late String agenceNom;
  late String nom;
  late String agenceId;
  late String password;

  DashboardAgentScreen(
      {required this.agenceNom,
      required this.nom,
      required this.agenceId,
      required this.password});

  @override
  _DashboardAgentScreenState createState() => _DashboardAgentScreenState();
}

class _DashboardAgentScreenState extends State<DashboardAgentScreen> {
  int? _selectedSegment;
  late Future<QuerySnapshot> _transfersFuture;

  @override
  void initState() {
    _transfersFuture = FirebaseFirestore.instance.collection('transfers').get();
    super.initState();
    _selectedSegment = 0;
  }

  @override
  void dispose() {
    super.dispose();
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: AppColors.backgroundWhite,
                height: 70,
                margin: EdgeInsets.only(left: 2, top: 1, right: 2),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "HOME",
                        style: TextStyle(
                            color: AppColors.textColorBlack,
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                      Container(
                        // margin: EdgeInsets.only(left: AppTexts.defaultPadding),
                        padding: EdgeInsets.symmetric(
                          horizontal: AppTexts.defaultPadding,
                          vertical: AppTexts.defaultPadding / 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/profile_pic.png",
                              height: 38,
                            ),
                            Text(
                              widget.nom,
                              style: TextStyle(color: AppColors.textColorBlack),
                            ),
                            Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8, top: 8, right: 8),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Card(
                          color: Colors.white,
                          surfaceTintColor: Colors.transparent,
                          shadowColor: Color.fromARGB(255, 243, 220, 204),
                          elevation: 4,
                          child: Container(
                            // margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                              border: Border.all(color: Colors.black12),
                            ),
                            // color: AppColors.backgroundWhite,
                            width: 600,
                            height: 100,
                            child: Center(
                              child: Text(
                                widget.agenceNom,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: AppColors.textColorBlack,
                                    fontWeight: FontWeight.w100),
                                // textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              child: Card(
                                color: Colors.white,
                                surfaceTintColor: Colors.transparent,
                                shadowColor: Color.fromARGB(255, 243, 220, 204),
                                elevation: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DialogEnvoyer(
                                            agenceNom: widget.agenceNom,
                                            nom: widget.nom,
                                            agenceId: widget.agenceId,
                                            password: widget.password,
                                          );
                                        });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      // border: Border.all(color: Colors.blue, width: 2),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/images/envoyer.png',
                                          height: 100.0,
                                          width: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                        Text(
                                          "Envoyer",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: AppColors.textColorBlack,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DialogTransaction(
                                        agenceNom: widget.agenceNom,
                                        nom: widget.nom,
                                        agenceId: widget.agenceId,
                                        password: widget.password,
                                      );
                                    });
                              },
                              child: Container(
                                height: 200,
                                width: 200,
                                child: Card(
                                  color: Colors.white,
                                  surfaceTintColor: Colors.transparent,
                                  shadowColor: Color.fromARGB(255, 243, 220, 204),
                                  elevation: 4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      // border: Border.all(color: Colors.blue, width: 2),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/images/transactions.png',
                                          height: 100.0,
                                          width: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                        Text(
                                          "Transactions",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: AppColors.textColorBlack,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DialogRecevoir(
                                        agenceNom: widget.agenceNom,
                                        nom: widget.nom,
                                        agenceId: widget.agenceId,
                                        password: widget.password,
                                      );
                                    });
                              },
                              child: Container(
                                height: 200,
                                width: 200,
                                child: Card(
                                  color: Colors.white,
                                  surfaceTintColor: Colors.transparent,
                                  shadowColor:
                                      Color.fromARGB(255, 243, 220, 204),
                                  elevation: 4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      // border: Border.all(color: Colors.blue, width: 2),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/images/recevoir.png',
                                          height: 100.0,
                                          width: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                        Text(
                                          "Recevoir",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: AppColors.textColorBlack,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              child: Card(
                                color: Colors.white,
                                surfaceTintColor: Colors.transparent,
                                shadowColor: Color.fromARGB(255, 243, 220, 204),
                                elevation: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    // border: Border.all(color: Colors.blue, width: 2),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/service1.png',
                                        height: 100.0,
                                        width: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        "Services",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: AppColors.textColorBlack,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 200,
                              child: Card(
                                color: Colors.white,
                                surfaceTintColor: Colors.transparent,
                                shadowColor: Color.fromARGB(255, 243, 220, 204),
                                elevation: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    // border: Border.all(color: Colors.blue, width: 2),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/compte.png',
                                        height: 100.0,
                                        width: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        "Compte agence",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: AppColors.textColorBlack,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 200,
                              child: Card(
                                color: Colors.white,
                                surfaceTintColor: Colors.transparent,
                                shadowColor: Color.fromARGB(255, 243, 220, 204),
                                elevation: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    // border: Border.all(color: Colors.blue, width: 2),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/seting.png',
                                        height: 100.0,
                                        width: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        "Parametres",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: AppColors.textColorBlack,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 510,
                      width: 460.200,
                      child: Card(
                        color: Colors.white,
                        surfaceTintColor: Colors.transparent,
                        shadowColor: Color.fromARGB(255, 243, 220, 204),
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "Activités recentes",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: AppColors.textColorBlack),
                                textAlign: TextAlign.center,
                              ),
                              Divider(),
                              Container(
                                height: 420,
                                child: Column(
                                  children: [
                                    Center(
                                      child: Container(
                                        height: 420,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CupertinoSlidingSegmentedControl<
                                                int>(
                                              children: {
                                                0: Text('Tous'),
                                                1: Text('Envoyés'),
                                                2: Text('Retirés'),
                                              },
                                              groupValue: _selectedSegment,
                                              onValueChanged: (int? value) {
                                                setState(() {
                                                  _selectedSegment = value;
                                                });
                                              },
                                            ),
                                            // SizedBox(height: 20),
                                            Flexible(
                                              fit: FlexFit.loose,
                                              // Utilisez Expanded pour que le contenu prenne tout l'espace restant
                                              child:
                                                  _getContentBasedOnSegment(), // Appelez la méthode ici
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            
                            ],
                          ),
                        ),
                      ),
                    )
                 
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8, left: 2, bottom: 2, right: 2),
                child: FooterAgent(),
              )
            ],
          )),
        );
      },
    );
  }

  Widget _getContentBasedOnSegment() {
    switch (_selectedSegment) {
      case 0:
        return Container(
            child: FutureBuilder<QuerySnapshot>(
          future: _transfersFuture,
          builder: (context, snapshot) {
            final documents = snapshot.data?.docs ?? [];

            final filteredTransfers = documents
                .where((doc) =>
                    (doc['destinationAgencyName'] == widget.agenceNom ||
                    doc['statusTransfert'] == 'En cours' ) &&
                    (doc['statusTransfert'] == 'Retirer' ||
                    doc['origineAgencyName'] == widget.agenceNom))
                .toList(); 

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return ListView.builder(
              itemCount: filteredTransfers.length,
              itemBuilder: (context, index) {
                DocumentSnapshot transfer = filteredTransfers[index];
                return Column(
                  children: [
                    Divider(),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (transfer['statusTransfert'] == 'Retirer')
                            Text(
                              'De: ${transfer['origineAgencyName']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )
                          else
                            Text(
                              'À: ${transfer['destinationAgencyName']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                        ],
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Beneficiaire: ${transfer['beneficiaryName']}'),
                          Text('Code de retrait: ${transfer['codeRetrait']}'),
                          Text('Montant: ${transfer['montant']}'),
                          if (transfer['statusTransfert'] == 'Retirer')
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Envoyé le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['date']))} à ${transfer['heure']}',
                                    style: TextStyle(fontSize: 14)),
                                Text(
                                    'Retiré le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['dateRetrait']))} à ${transfer['heureRetrait']}',
                                    style: TextStyle(fontSize: 14)),
                                    //  Icon(Icons.arrow_right, size: 16.0),
                              ],
                            )
                          else 
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(
                                'Envoyé le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['date']))} à ${transfer['heure']}',
                                style: const TextStyle(fontSize: 14)),
                                // Icon(Icons.arrow_left, size: 16.0),
                                ]
                                )
                          
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (transfer['statusTransfert'] == 'Retirer')
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green[300],
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text(
                                'Déjà Retiré',
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () async {
                                // String id = transfer['id'];
                                // String passeword =
                                //     transfer['destinationPassewordAgent'];
                                // retirerFond(context, passeword, id);
                                // print(passeword + " contre" + id);
                              },
                            )
                          else
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue[300],
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text(
                                'En cours',
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () async {
                                // String id = transfer['id'];
                                // String passeword =
                                //     transfer['destinationPassewordAgent'];
                                // retirerFond(context, passeword, id);
                                // print(passeword + " contre" + id);
                              },
                            )
                        ],
                      ),
                    ),
                    Divider()
                  ],
                );
              },
            );
          },
        ));
     
      case 1:
       return Container(
            child: FutureBuilder<QuerySnapshot>(
          future: _transfersFuture,
          builder: (context, snapshot) {
            final documents = snapshot.data?.docs ?? [];

            final filteredTransfers = documents
                .where((doc) =>
                    doc['origineAgencyName'] == widget.agenceNom &&
                    doc['statusTransfert'] == 'En cours' )
                .toList();

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return ListView.builder(
              itemCount: filteredTransfers.length,
              itemBuilder: (context, index) {
                DocumentSnapshot transfer = filteredTransfers[index];
                return Column(
                  children: [
                    Divider(),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (transfer['statusTransfert'] == 'Retirer')
                            Text(
                              'De: ${transfer['origineAgencyName']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )
                          else
                            Text(
                              'À: ${transfer['destinationAgencyName']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                        ],
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Beneficiaire: ${transfer['beneficiaryName']}'),
                          Text('Code de retrait: ${transfer['codeRetrait']}'),
                          Text('Montant: ${transfer['montant']}'),
                          if (transfer['statusTransfert'] == 'Retirer')
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Envoyé le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['date']))} à ${transfer['heure']}',
                                    style: TextStyle(fontSize: 14)),
                                Text(
                                    'Retiré le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['dateRetrait']))} à ${transfer['heureRetrait']}',
                                    style: TextStyle(fontSize: 14)),
                                    //  Icon(Icons.arrow_right, size: 16.0),
                              ],
                            )
                          else 
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(
                                'Envoyé le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['date']))} à ${transfer['heure']}',
                                style: const TextStyle(fontSize: 14)),
                                // Icon(Icons.arrow_left, size: 16.0),
                                ]
                                )
                          
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (transfer['statusTransfert'] == 'Retirer')
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green[300],
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text(
                                'Déjà Retiré',
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () async {
                                // String id = transfer['id'];
                                // String passeword =
                                //     transfer['destinationPassewordAgent'];
                                // retirerFond(context, passeword, id);
                                // print(passeword + " contre" + id);
                              },
                            )
                          else
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue[300],
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text(
                                'En cours',
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () async {
                                // String id = transfer['id'];
                                // String passeword =
                                //     transfer['destinationPassewordAgent'];
                                // retirerFond(context, passeword, id);
                                // print(passeword + " contre" + id);
                              },
                            )
                        ],
                      ),
                    ),
                    Divider()
                  ],
                );
              },
            );
          },
        ));
     
      case 2:
       return Container(
            child: FutureBuilder<QuerySnapshot>(
          future: _transfersFuture,
          builder: (context, snapshot) {
            final documents = snapshot.data?.docs ?? [];

            final filteredTransfers = documents
                .where((doc) =>
                    doc['destinationAgencyName'] == widget.agenceNom &&
                    doc['statusTransfert'] == 'Retirer' )
                .toList();

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return ListView.builder(
              itemCount: filteredTransfers.length,
              itemBuilder: (context, index) {
                DocumentSnapshot transfer = filteredTransfers[index];
                return Column(
                  children: [
                    Divider(),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (transfer['statusTransfert'] == 'Retirer')
                            Text(
                              'De: ${transfer['origineAgencyName']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )
                          else
                            Text(
                              'À: ${transfer['destinationAgencyName']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                        ],
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Beneficiaire: ${transfer['beneficiaryName']}'),
                          Text('Code de retrait: ${transfer['codeRetrait']}'),
                          Text('Montant: ${transfer['montant']}'),
                          if (transfer['statusTransfert'] == 'Retirer')
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Envoyé le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['date']))} à ${transfer['heure']}',
                                    style: TextStyle(fontSize: 14)),
                                Text(
                                    'Retiré le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['dateRetrait']))} à ${transfer['heureRetrait']}',
                                    style: TextStyle(fontSize: 14)),
                                    //  Icon(Icons.arrow_right, size: 16.0),
                              ],
                            )
                          else 
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(
                                'Envoyé le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['date']))} à ${transfer['heure']}',
                                style: const TextStyle(fontSize: 14)),
                                // Icon(Icons.arrow_left, size: 16.0),
                                ]
                                )
                          
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (transfer['statusTransfert'] == 'Retirer')
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green[300],
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text(
                                'Déjà Retiré',
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () async {
                                // String id = transfer['id'];
                                // String passeword =
                                //     transfer['destinationPassewordAgent'];
                                // retirerFond(context, passeword, id);
                                // print(passeword + " contre" + id);
                              },
                            )
                          else
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue[300],
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text(
                                'En cours',
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () async {
                                // String id = transfer['id'];
                                // String passeword =
                                //     transfer['destinationPassewordAgent'];
                                // retirerFond(context, passeword, id);
                                // print(passeword + " contre" + id);
                              },
                            )
                        ],
                      ),
                    ),
                    Divider()
                  ],
                );
              },
            );
          },
        ));
     
      
      default:
        return Center(child: Text('Aucun segment sélectionné'));
    }
  }

}
