import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:agence_transfert/configurations/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DialogAgent {
  List<TextEditingController> controllers =
      List.generate(3, (_) => TextEditingController());

  TextStyle inputFieldTextStyle = TextStyle(color: Colors.black, fontSize: 16);

  String? validateLeastValue(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          surfaceTintColor: Colors.transparent,
          contentTextStyle: const TextStyle(color: Colors.red),
          title: _addAlertDialogTitle(context),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          content: Builder(builder: (context) {
            var width = MediaQuery.of(context).size.width;
            var height = MediaQuery.of(context).size.height;
            var newWidth = width - width * .25;
            var newHeight = height > 700.0 ? 700.0 : height;
            return Container(
              height: newHeight,
              width: newWidth,
              padding: const EdgeInsets.only(
                  left: 36, right: 36, top: 24, bottom: 24),
              child: _addDialogContent(context),
            );
          }),
        );
      },
    );
  }

Future<bool> ajouterAgent(String nom, String password, String phone) async {
  try {
    final configDocRef = FirebaseFirestore.instance.collection('config').doc('lastAgentId');
    DocumentSnapshot lastIdDoc = await configDocRef.get();

    // Vérifier si le document existe et si lastAgenceId est un entier
   int lastId = lastIdDoc.exists && lastIdDoc.data()!= null? (lastIdDoc.data() as Map<String, dynamic>)['lastAgentId']?? 0 : 0;

    int newId = lastId + 1;

    final collectionRef = FirebaseFirestore.instance.collection('agents');
    await collectionRef.add({
      'id': newId,
      'nom': nom,
      'password': password,
      'phone': phone,
    });

    // Mettre à jour la dernière valeur d'ID dans le document de configuration
    await configDocRef.set({'lastAgentId': newId}, SetOptions(merge: true));

    print('Agent ajouté avec succès');
    return true;
  } catch (e) {
    print('Erreur lors de l\'ajout de l\'agent : $e');
    return false;
  }
}

  Widget _addAlertDialogTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Nouvelle agence',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        Container(
          width: 24,
          child: ElevatedButton(
            onPressed: () async {
              bool success = await ajouterAgent(
                controllers[0].text,
                controllers[1].text,
                controllers[2].text,
              );
              if (success) {
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: const CircleBorder(),
            ),
            child: const Icon(
              Icons.close,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _addDialogContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _getNomAgenceField('Nom', controllers[0]),
          _getNomAgenceField('Password', controllers[1]),
          _getNomAgenceField('Telephone', controllers[2]),
          // Ajoutez d'autres widgets ici
          add100VerticalSpace(),

          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 150,
              child: ElevatedButton(
                onPressed: () async {
                  bool success = await ajouterAgent(
                    controllers[0].text,
                    controllers[1].text,
                    controllers[2].text,
                  );
                  // Vérifiez si le widget est toujours monté
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      AppTexts.add,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getNomAgenceField(
      String labelText, TextEditingController controller) {
    return TextFormField(
      keyboardType: TextInputType.text,
      maxLength: 40,
      // Utilisation de la constante définie
      decoration: _getInputDecoration(labelText),
      validator: (value) =>
          validateLeastValue(value, 'Veuillez entrer au moins 5 caractères'),
      onSaved: (value) {
        // _enteredTitle = value!;
      },
      controller: controller,
    );
  }

  InputDecoration _getInputDecoration(String labelText) {
    return InputDecoration(
      fillColor: Colors.white, //const Color(0xffF6F8FB).withOpacity(0.5),
      filled: true,
      border: const OutlineInputBorder(),
      label: Text(
        labelText,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
