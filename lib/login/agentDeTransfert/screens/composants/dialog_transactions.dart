import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DialogTransaction extends StatefulWidget {
  late String agenceNom;
  late String nom;
  late String agenceId;
  late String password;

  DialogTransaction(
      {required this.agenceNom,
      required this.nom,
      required this.agenceId,
      required this.password});

  @override
  _DialogTransactionState createState() => _DialogTransactionState();
}

class _DialogTransactionState extends State<DialogTransaction> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  late Future<QuerySnapshot> _transfersFuture;
  final ValueNotifier<DateTime> _selectedDateNotifier =
      ValueNotifier<DateTime>(DateTime.now());
  DateTime _selectedDate = DateTime.now();
  DateTime? _filterDate;
  int? _selectedSegment;

  String? _selectedAgenceId;
  String? _selectedAgenceNom;

  late CollectionReference _agencesRef;
  late Stream<QuerySnapshot> _agencesStream;

  @override
  void initState() {
    _transfersFuture = FirebaseFirestore.instance.collection('transfers').get();
    super.initState();
    _selectedSegment = 0;
    _nomController.text =
        DateFormat('dd/MM/yyyy').format(_selectedDateNotifier.value);

    _filterDate = _selectedDate;

    _agencesRef = FirebaseFirestore.instance.collection('agences');
    _agencesStream =
        _agencesRef.where('estAttribuee', isEqualTo: true,).snapshots();
  }

  @override
  void dispose() {
    _nomController.dispose();
    super.dispose();
  }

  String origineAgencyId() {
    return widget.agenceId;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateNotifier.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDateNotifier.value) {
      setState(() {
        _selectedDateNotifier.value = picked;
        // Mise à jour du contrôleur avec la date formatée pour l'affichage
        _nomController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var newWidth = width - width * .40;
    var newHeight = height > 500.0 ? 500.0 : height;
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      title: Column(
        children: [
          Text(
            'TRANSACTIONS',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          Text(
            'AGENCE ${widget.agenceNom.toUpperCase()}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          // SizedBox(height: 20),
        ],
      ),
      content: Container(
        height: newHeight,
        width: newWidth,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 51,
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // flex: 1,
                        child: Container(
                          width: 145,
                          child: GestureDetector(
                            onTap: () => _selectDate(context),
                            child: AbsorbPointer(
                              absorbing: true,
                              child: TextFormField(
                                controller: _nomController,
                                decoration:
                                    _getInputDecoration1("Trier par date"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer une date';
                                  }
                                  return null;
                                },
                                readOnly: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          width: 230,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: _agencesStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<DropdownMenuItem<String>> agences = snapshot.data!.docs
                                    .where((doc) =>
                                        doc.get('nom') !=
                                        widget.agenceNom) // Filtre côté client
                                    .map((doc) {
                                  return DropdownMenuItem<String>(
                                    value: doc.id,
                                    child: Text(doc.get('nom')),
                                  );
                                }).toList();
                                if (agences.isEmpty) {
                                  return Text(
                                    'Aucune agence disponible pour le transfert.',
                                    style: TextStyle(color: Colors.red),
                                  );
                                }

                                return DropdownButtonFormField<String>(
                                  decoration: _getInputDecoration4("AGENCE"),
                                  value: _selectedAgenceId,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedAgenceId = value;
                                      _selectedAgenceNom = snapshot.data!.docs
                                          .firstWhere((doc) => doc.id == value)
                                          .get('nom');
                                    });
                                  },
                                  items: agences,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Veuillez sélectionner une agence';
                                    }
                                    return null;
                                  },
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      
                    ],
                  ),
                ),
                Container(
                  child: CupertinoSlidingSegmentedControl<int>(
                    padding: EdgeInsets.all(10),
                    children: {
                      0: Text('Tous'),
                      1: Text('Envoyés'),
                      2: Text('Receptions'),
                    },
                    groupValue: _selectedSegment,
                    onValueChanged: (int? value) {
                      setState(() {
                        _selectedSegment = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Flexible(
              fit: FlexFit.loose,
              // Utilisez Expanded pour que le contenu prenne tout l'espace restant
              child: _getContentBasedOnSegment(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getContentBasedOnSegment() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var newWidth = width - width * .40;
    var newHeight = height > 500.0 ? 500.0 : height;
    switch (_selectedSegment) {
      case 0:
        return Container(
            height: newHeight,
            width: newWidth,
            child: ValueListenableBuilder<DateTime>(
              valueListenable: _selectedDateNotifier,
              builder: (context, selectedDate, child) {
                print(_selectedDateNotifier);
                return FutureBuilder<QuerySnapshot>(
                  future: _transfersFuture,
                  builder: (context, snapshot) {
                    final documents = snapshot.data?.docs ?? [];
                    // final filteredTransfers = documents.where((doc) {
                    //   DateTime docDate = DateTime.parse(doc[
                    //       'date']); // Assurez-vous que cela correspond au format de votre date dans Firestore
                    //   bool isSameDate = docDate.year == selectedDate.year &&
                    //       docDate.month == selectedDate.month &&
                    //       docDate.day == selectedDate.day;
                    //   return isSameDate ||
                    //       ((doc['destinationAgencyName'] == widget.agenceNom ||
                    //               doc['statusTransfert'] == 'En cours') &&
                    //           (doc['statusTransfert'] == 'Retirer' ||
                    //               doc['origineAgencyName'] ==
                    //                   widget.agenceNom));

                                      
                    // }).toList();

                    final filteredTransfers = documents
                    .where((doc) =>
                        (doc['origineAgencyName'] == widget.agenceNom &&
                            doc['statusTransfert'] == 'En cours') ||
                        (doc['origineAgencyName'] == widget.agenceNom &&
                            doc['statusTransfert'] == 'Retirer'))
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
                        // Le reste de votre code pour construire chaque élément de la liste...
                      },
                    );
                  },
                );
              },
            ));
      case 1:
        return Container(
            height: newHeight,
            width: newWidth,
            child: FutureBuilder<QuerySnapshot>(
              future: _transfersFuture,
              builder: (context, snapshot) {
                final documents = snapshot.data?.docs ?? [];

                final filteredTransfers = documents
                    .where((doc) =>
                        (doc['origineAgencyName'] == widget.agenceNom &&
                            doc['statusTransfert'] == 'En cours') ||
                        (doc['origineAgencyName'] == widget.agenceNom &&
                            doc['statusTransfert'] == 'Retirer'))
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
                                  '${transfer['origineAgencyName']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )
                              else
                                Text(
                                  'Vers: ${transfer['destinationAgencyName']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                            ],
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Beneficiaire: ${transfer['beneficiaryName']}'),
                              Text(
                                  'Code de retrait: ${transfer['codeRetrait']}'),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Envoyé le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['date']))} à ${transfer['heure']}',
                                          style: const TextStyle(fontSize: 14)),
                                      // Icon(Icons.arrow_left, size: 16.0),
                                    ])
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
            height: newHeight,
            width: newWidth,
            child: FutureBuilder<QuerySnapshot>(
              future: _transfersFuture,
              builder: (context, snapshot) {
                final documents = snapshot.data?.docs ?? [];

                final filteredTransfers = documents
                    .where((doc) =>
                        (doc['destinationAgencyName'] == widget.agenceNom &&
                            doc['statusTransfert'] == 'En cours') ||
                        (doc['destinationAgencyName'] == widget.agenceNom &&
                            doc['statusTransfert'] == 'Retirer'))
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
                                  '${transfer['destinationAgencyName']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )
                              else
                                Text(
                                  'De: ${transfer['origineAgencyName']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                            ],
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Beneficiaire: ${transfer['beneficiaryName']}'),
                              Text(
                                  'Code de retrait: ${transfer['codeRetrait']}'),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Envoyé le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['date']))} à ${transfer['heure']}',
                                          style: const TextStyle(fontSize: 14)),
                                      // Icon(Icons.arrow_left, size: 16.0),
                                    ])
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
        return Container(
          height: newHeight,
          width: newWidth,
        );
    }
  }

  InputDecoration _getInputDecoration1(String hints) {
    return InputDecoration(
      fillColor: const Color(0xffF6F8FB).withOpacity(0.5),
      filled: true,
      border: const OutlineInputBorder(),
      label: Text(
        hints,
        style: const TextStyle(color: Colors.black87),
      ),
      suffixIcon: Icon(
        Icons.calendar_month_outlined,
      ),
    );
  }

  InputDecoration _getInputDecoration4(String hints) {
    return InputDecoration(
      fillColor: const Color(0xffF6F8FB).withOpacity(0.5),
      filled: true,
      border: const OutlineInputBorder(),
      label: Text(
        hints,
        style: const TextStyle(color: Colors.black87),
      ),
    );
  }
}
