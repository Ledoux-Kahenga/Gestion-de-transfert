import 'dart:math';

import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DialogAgent extends StatefulWidget {
  @override
  _DialogAgentState createState() => _DialogAgentState();
}

class _DialogAgentState extends State<DialogAgent> {
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
        _agencesRef.where('estAttribuee', isEqualTo: false).snapshots();
  }

  String generateStrongPassword(int length) {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  Random random = Random();
  String password = '';
  for (int i = 0; i < length; i++) {
    password += characters[random.nextInt(characters.length)];
  }
  return password;
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
            'NOUVEL AGENT',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          Text(
            'AGENCE BAUDOUIN LA COLOMBE',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nomController,
                  decoration: _getInputDecoration1("NOM"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un nom';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: _getInputDecoration2("MOT DE PASSE"),
                        enabled: false,
                        obscureText: true,
                        keyboardType: TextInputType.number, // Affiche un clavier numérique
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un mot de passe';
                          }
                          return null;
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 6),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white, // Couleur du texte
                            backgroundColor: Colors.blue[400], // Couleur de fond
                            padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 24), // Espacement du texte
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Coins arrondis
                            ),
                          ),
                          child: Text(
                            'Generer',
                            style: TextStyle(
                              fontSize: 16, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          onPressed: () {
                            String newPassword = generateStrongPassword(4); // Générer un mot de passe de 10 caractères
                            _passwordController.text = newPassword;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 16),
                TextFormField(
                  controller: _contactController,
                  decoration: _getInputDecoration3("CONTACT"),
                  maxLength: 7,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un contact';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                StreamBuilder<QuerySnapshot>(
                  stream: _agencesStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<DropdownMenuItem<String>> agences = snapshot
                          .data!.docs
                          .where((doc) => !doc.get('estAttribuee'))
                          .map((doc) {
                        return DropdownMenuItem(
                          value: doc.id,
                          child: Text(doc.get('nom')),
                        );
                      }).toList();

                      if (agences.isEmpty) {
                        return Text(
                          'Désolé, il n\'y a plus d\'agence disponible pour attribuer un agent.',
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
                    } else if (snapshot.hasError) {
                      return Text('Erreur lors du chargement des agences');
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
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
                    _createAgent();
                    print('Agent créé avec succès');
                    Navigator.of(context).pop();
                  }
                },
        ),
      ],
    );
  }

  void _createAgent() async {
    final agentRef = FirebaseFirestore.instance.collection('agents').doc();
    // final configDocRef =
    //     FirebaseFirestore.instance.collection('config').doc('lastAgentId');
    // DocumentSnapshot lastIdDoc = await configDocRef.get();

    // Vérifier si le document existe et si lastAgenceId est un entier
    // int lastId = lastIdDoc.exists && lastIdDoc.data() != null
    //     ? (lastIdDoc.data() as Map<String, dynamic>)['lastAgentId'] ?? 0
    //     : 0;

    // int idAgent = lastId + 1;
    // final agentRefe = FirebaseFirestore.instance.collection('agents').doc();

    String documentIdAgent = agentRef.id;
    DateTime dateCreationAgent = DateTime.now();

    agentRef.set({
      'id': documentIdAgent,
      'nom': _nomController.text,
      'password': _passwordController.text,
      'contact': '+(243) ' + _contactController.text,
      'agenceId': _selectedAgenceId,
      'agenceNom': _selectedAgenceNom,
      'dateCreationAgent': dateCreationAgent,
    }).then((value) {
      // Mettre à jour le document de l'agence pour référencer l'agent et passer estAttribuee à true
      _agencesRef.doc(_selectedAgenceId).update({
        'estAttribuee': true,
        'agentId': agentRef.id,
        'agentName': _nomController.text,
        'agentPasseword': _passwordController.text, 
      });
    }).catchError((error) {
      print('Erreur lors de la création de l\'agent: $error');
    });
    // Mettre à jour la dernière valeur d'ID dans le document de configuration
    // await configDocRef.set({'lastAgentId': idAgent}, SetOptions(merge: true));
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
