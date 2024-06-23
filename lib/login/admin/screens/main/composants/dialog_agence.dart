import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:agence_transfert/configurations/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DialogAgence extends StatefulWidget {
  @override
  _DialogAgenceState createState() => _DialogAgenceState();
}

class _DialogAgenceState extends State<DialogAgence> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController villeController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();

  String? selectedProvince; // Initialiser à null
  String? selectedVille;

  String currentText = "";

  // Dictionnaire pour associer les provinces à leurs villes
  Map<String, List<String>> provincesAndVilles = {
    "Équateur": [
      "Mbandaka",
      "Boende",
      "Bikoro",
      "Ingende",
      "Bolomba",
      "Befale",
      "Binga",
      "Businga",
      "Djolu",
      "Kungu",
      "Lokutu",
      "Lukolela",
      "Monkoto",
      "Ndole",
      "Ntondo",
      "Yalifafu"
    ],
    "Haut-Katanga": [
      "Lubumbashi",
      "Likasi",
      "Kipushi",
      "Kambove",
      "Kasumbalesa",
      "Mitwaba",
      "Pweto"
    ],
    "Haut-Lomami": [
      "Kamina",
      "Kaniama",
      "Kambone",
      "Bukama",
      "Kabongo",
      "Malemba Nkulu",
      "Mulongo"
    ],
    "Kasaï": [
      "Tshikapa",
      "Luebo",
      "Mweka",
      "Ilebo",
      "Kananga",
      "Mwene-Ditu",
      "Demba",
      "Kamonia"
    ],
    "Kasaï-Central": [
      "Kananga",
      "Luiza",
      "Dekese",
      "Dibaya",
      "Kazumba",
      "Kmonia",
      "Tshimbulu"
    ],
    "Kasaï-Oriental": [
      "Mbujimayi",
      "Lusambo",
      "Dibaya",
      "Miabi",
      "Tshilenge",
      "Lodja",
      "Katako-Kombe"
    ],
    "Kinshasa": ["Kinshasa"],
    "Kongo-Central": [
      "Matadi",
      "Boma",
      "Lukala",
      "Seke-Banza",
      "Moanda",
      "Tshela",
      "Muanda"
    ],
    "Lualaba": ["Kolwezi", "Dilolo", "Kapanga", "Lubudi", "Kalongwe", "Sandoa"],
    "Nord-Kivu": [
      "Goma",
      "Beni",
      "Butembo",
      "Lubero",
      "Masisi",
      "Rutshuru",
      "Walikale"
    ],
    "Sud-Kivu": [
      "Bukavu",
      "Uvira",
      "Walungu",
      "Kabare",
      "Kalehe",
      "Idjwi",
      "Mwenga",
      "Shabunda",
      "Fizi",
      "Minembwe"
    ],
    "Tanganyika": [
      "Kalemie",
      "Moba",
      "Nyunzu",
      "Kongolo",
      "Manono",
      "Kabalo",
      "Kirungu"
    ],
  };

  @override
  void dispose() {
    provinceController.dispose();
    villeController.dispose();
    adresseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var newWidth = width - width * .50;
    var newHeight = height > 500.0 ? 500.0 : height;
    return Container(
      child: AlertDialog(
        backgroundColor: AppColors.backgroundWhite,
        // surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        title: Column(
          children: [
            Text(
              'NOUVELLE AGENCE BAUDOUIN',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Text(
              'LA COLOMBE',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ],
        ),
        content: Container(
          height: newHeight,
          width: newWidth,
          padding:
              const EdgeInsets.only(left: 60, right: 60, top: 40, bottom: 40),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DropdownButtonFormField<String>(
                    hint: Text('Sélectionnez une province'),
                    value: selectedProvince,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: provincesAndVilles.keys.toList().map((province) {
                      return DropdownMenuItem<String>(
                        value: province,
                        child: Text(province),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedProvince = value;
                        selectedVille =
                            null; // Réinitialiser la ville sélectionnée
                        provinceController.text = selectedProvince ??
                            ''; // Vider le champ de la ville
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Veuillez sélectionner une province';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    hint: Text('Sélectionnez une ville'),
                    value: selectedVille,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: selectedProvince != null
                        ? provincesAndVilles[selectedProvince]!.map((ville) {
                            return DropdownMenuItem<String>(
                              value: ville,
                              child: Text(ville),
                            );
                          }).toList()
                        : [],
                    onChanged: (value) {
                      setState(() {
                        selectedVille = value;
                        villeController.text = value ?? "";
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Veuillez sélectionner une ville';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: adresseController,
                    decoration: InputDecoration(
                      fillColor: const Color(0xffF6F8FB).withOpacity(0.5),
                      filled: true,
                      border: const OutlineInputBorder(),
                      label: Text(
                        "ADRESSE",
                        style: const TextStyle(color: Colors.black87),
                      ),
                      suffixIcon: Icon(Icons.room),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ce champ est requis';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
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
            child: const Text(
              'Annuler',
              style: TextStyle(color: Colors.white),
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
              child: const Text(
                'Ajouter',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _createAgence(
                      provinceController.text.trim(),
                      villeController.text.trim(),
                      adresseController.text.trim());
                  print('Agence créé avec succès');
                  Navigator.of(context).pop();
                }
              }),
        ],
      ),
    );
  }
}

void _createAgence(String province, String ville, String adresse) async {
  final agenceRef = FirebaseFirestore.instance.collection('agences').doc();
 

  String documentIdAgence = agenceRef.id;
  DateTime dateCreationAgence = DateTime.now();

  agenceRef.set({
    'id': documentIdAgence,
    'nom': "Baudouin - $ville",
    'agentId': "Non attribué",
    'agentName': "Non attribué",
    'agentPasseword': "Non definit",
    'province': province,
    'ville': ville,
    'adresse': adresse,
    'estAttribuee': false,
    'dateCreationAgence' : dateCreationAgence
  }).then((value) {
 
  }).catchError((error) {
    print('Erreur lors de la création de l\'agence: $error');
  });

}

InputDecoration _getInputDecoration(String hints) {
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
