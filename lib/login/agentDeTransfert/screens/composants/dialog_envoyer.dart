import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DialogEnvoyer extends StatefulWidget {
  late String agenceNom;
  late String nom;
  late String agenceId;

  DialogEnvoyer(
      {required this.agenceNom, required this.nom, required this.agenceId});

  @override
  _DialogEnvoyerState createState() => _DialogEnvoyerState();
}

class _DialogEnvoyerState extends State<DialogEnvoyer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  String? _selectedAgenceId;
  String? _selectedAgenceNom;

  late CollectionReference _agencesRef;
  late Stream<QuerySnapshot> _agencesStream;

  @override
  void initState() {
    super.initState();
    _agencesRef = FirebaseFirestore.instance.collection('agences');
    _agencesStream =
        _agencesRef.where('estAttribuee', isEqualTo: true).snapshots();
  }

  String origineAgencyId() {
    return widget.agenceId;
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
      title: Column(
        children: [
          Text(
            'TRANSFERT DE FONDS',
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
        ],
      ),
      content: SingleChildScrollView(
        child: Container(
          height: newHeight,
          width: newWidth,
          padding:
              const EdgeInsets.only(left: 60, right: 60, top: 40, bottom: 40),
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextFormField(
                controller: _nomController,
                decoration: _getInputDecoration1("NOM DU BENEFICIAIRE"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: _getInputDecoration2("CODE DE RETRAIT"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un mot de passe';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _contactController,
                decoration: _getInputDecoration3("MONTANT"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un motant';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              StreamBuilder<QuerySnapshot>(
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
                      decoration: _getInputDecoration4("AGENCE DE DESTINATION"),
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
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )
            ]),
          ),
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
            'Annuler',
            style: TextStyle(
              fontSize: 16, // Taille de la police
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white, // Couleur du texte
            backgroundColor: Colors.green, // Couleur de fond
            padding: EdgeInsets.symmetric(
                horizontal: 16, vertical: 12), // Espacement du texte
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18), // Coins arrondis
            ),
          ),
          child: Text(
            'Ajouter',
            style: TextStyle(
              fontSize: 16, // Taille de la police
            ),
          ),
          onPressed: _selectedAgenceId == null
              ? null
              : () {
                  if (_formKey.currentState!.validate()) {
                    transferFunds();
                    print('Agent créé avec succès');
                    Navigator.of(context).pop();
                  }
                },
        ),
      ],
    );
  }

  void transferFunds() async {
    if (_formKey.currentState!.validate()) {
      String beneficiaryName = _nomController.text;
      String codeRetrait = _passwordController.text;
      String montant = _contactController.text;
      String destinationAgencyId = _selectedAgenceId!;
      String origineAgencyId = this
          .origineAgencyId(); // Utilisation de la fonction pour obtenir l'ID de l'agence d'origine
      String origineAgencyName = widget.agenceNom;
      DateTime temps = DateTime.now();
      String date =
          '${temps.year}-${temps.month.toString().padLeft(2, '0')}-${temps.day.toString().padLeft(2, '0')}';
      String heure =
          '${temps.hour.toString().padLeft(2, '0')}:${temps.minute.toString().padLeft(2, '0')}:${temps.second.toString().padLeft(2, '0')}';

      // Créer une référence de document avec un ID unique
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('transfers').doc();
      String id = docRef.id; // Obtenir l'ID unique généré

      try {
        await FirebaseFirestore.instance.collection('transfers').add({
          'id' : id,
          'beneficiaryName': beneficiaryName,
          'codeRetrait': codeRetrait,
          'montant': montant,
          'origineAgencyName': origineAgencyName,
          'destinationAgencyId': destinationAgencyId,
          'origineAgencyId': origineAgencyId,
          'date': date,
          'heure': heure,
          'temps': temps,
        });

        // Affichage d'un message de succès et fermeture du dialogue
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Transfert effectué avec succès')));
        Navigator.of(context).pop();
      } catch (e) {
        print('Erreur lors du transfert de fonds: $e');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Erreur: $e')));
      }
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
      suffixIcon: Icon(Icons.person_2_outlined),
    );
  }

  InputDecoration _getInputDecoration2(String hints) {
    return InputDecoration(
      fillColor: const Color(0xffF6F8FB).withOpacity(0.5),
      filled: true,
      border: const OutlineInputBorder(),
      label: Text(
        hints,
        style: const TextStyle(color: Colors.black87),
      ),
      suffixIcon: Icon(Icons.lock_outlined),
    );
  }

  InputDecoration _getInputDecoration3(String hints) {
    return InputDecoration(
      fillColor: const Color(0xffF6F8FB).withOpacity(0.5),
      filled: true,
      border: const OutlineInputBorder(),
      label: Text(
        hints,
        style: const TextStyle(color: Colors.black87),
      ),
      suffixIcon: Icon(Icons.location_city_outlined),
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
