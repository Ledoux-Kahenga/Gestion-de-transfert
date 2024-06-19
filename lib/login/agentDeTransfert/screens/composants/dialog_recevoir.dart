import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DialogRecevoir extends StatefulWidget {
  late String agenceNom;
  late String nom;
  late String agenceId;

  DialogRecevoir({
    required this.agenceNom,
    required this.nom,
    required this.agenceId,
  });

  @override
  _DialogRecevoirState createState() => _DialogRecevoirState();
}

class _DialogRecevoirState extends State<DialogRecevoir> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<QuerySnapshot> _transfersFuture;

  @override
  void initState() {
    _transfersFuture = FirebaseFirestore.instance.collection('transfers').get(); // Assurez-vous que 'transfers' est le nom de votre collection
    super.initState();
  }

  String origineAgencyId() {
    return widget.agenceId;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Transferts reçus'),
      content: FutureBuilder<QuerySnapshot>(
        future: _transfersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Erreur: ${snapshot.error}');
          } else {
            // Filtrer les transferts pour exclure ceux de l'agence courante
            List<DocumentSnapshot> filteredTransfers = snapshot.data!.docs.where((doc) => doc['origineAgencyId']!= widget.agenceId).toList();

            return ListView.builder(
              itemCount: filteredTransfers.length,
              itemBuilder: (context, index) {
                DocumentSnapshot transfer = filteredTransfers[index];
                return ListTile(
                  title: Text('Transfert ${index + 1}'),
                  subtitle: Text('De: ${transfer['origineAgencyName']}'), // Corrected the missing parenthesis
                );
              },
            );
          }
        },
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Fermer'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}