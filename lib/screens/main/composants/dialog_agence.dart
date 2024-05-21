import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:agence_transfert/configurations/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
// import 'package:form_validator/form_validator.dart';

class DialogAgence extends StatefulWidget {
  @override
  _DialogAgenceState createState() => _DialogAgenceState();
}

class _DialogAgenceState extends State<DialogAgence> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController villeController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  String selectedValue = '';

  String currentText = "";

  List<String> provinces = [
    "Bas-Uele",
    "Équateur",
    "Haut-Katanga",
    "Haut-Lomami",
    "Haut-Uele",
    "Ituri",
    "Kasaï",
    "Kasaï-Central",
    "Kasaï-Oriental",
    "Kinshasa",
    "Kongo-Central",
    "Kwango",
    "Kwilu",
    "Lomami",
    "Lualaba",
    "Mai-Ndombe",
    "Maniema",
    "Mongala",
    "Nord-Kivu",
    "Nord-Ubangi",
    "Sankuru",
    "Sud-Kivu",
    "Sud-Ubangi",
    "Tanganyika",
    "Tshopo",
    "Tshuapa",
  ];

  List<String> villesRDC = [
    'Bandundu',
    'Bukavu',
    'Goma',
    'Kalemie',
    'Kamina',
    'Kananga',
    'Kikwit',
    'Kindu',
    'Kisangani',
    'Kinshasa',
    'Kolwezi',
    'Likasi',
    'Lisala',
    'Lubumbashi',
    'Matadi',
    'Mbandaka',
    'Mbujimayi',
    'Muene-Ditu',
    'Tshikapa',
  ];

  List<String> territories = [
    "Aba",
    "Akula",
    "Alunguli",
    "Ankoro",
    "Anong",
    "Banana",
    "Bangassou",
    "Banningville",
    "Bélinge",
    "Bena-Leka",
    "Bena-Mpozo",
    "Bena-Tshiadi",
    "Beni",
    "Bikoro",
    "Binga",
    "Boende",
    "Bolomba",
    "Bosobolo",
    "Boya",
    "Bulungu",
    "Bumba",
    "Burhanihehe",
    "Bunia",
    "Butembohttps",
    "Butwa",
    "Butahe",
    "Dimbelenge",
    "Djolu",
    "Domaine de chasse de Rubi-Tele",
    "Dungu",
    "Fizi",
    "Fungurume",
    "Goma",
    "Gomba",
    "Gungu",
    "Haut-Katanga",
    "Ilebo",
    "Irumu",
    "Kabalo",
    "Kabambare",
    "Kabengere",
    "Kabeya-Kamwanga",
    "Kabinda",
    "Kabongo",
    "Kainama",
    "Kalemie",
    "Kalima",
    "Kalongo",
    "Kamilabi",
    "Kampene",
    "Kananga",
    "Kaniama",
    "Kapanga",
    "Kapiri",
    "Kasaji",
    "Kasansa",
    "Kasemena",
    "Kasongo",
    "Kasongo-Lunda",
    "Kasongo-Nyemba",
    "Kasulu",
    "Katako-Kombe",
    "Katana",
    "Katende",
    "Kati",
    "Katoka",
    "Katompe",
    "Katshungu",
    "Kenge",
    "Kiambi",
    "Kimpesi",
    "Kinkondja",
    "Kinshasa",
    "Kipushi",
    "Kitenge",
    "Kole",
    "Kolwezi",
    "Kongolo",
    "Kotakoli",
    "Kwango",
    "Kwilu",
    "Lemfu",
    "Libenge",
    "Liberia",
    "Likandale",
    "Lindi",
    "Lirunga",
    "Lisala",
    "Lobika",
    "Lodja",
    "Luebo",
    "Luiza",
    "Lukala",
    "Lukolela",
    "Lulimba",
    "Lulonga",
    "Lusambo",
    "Lutshima",
    "Lubudi",
    "Lubumbashi",
    "Lupatapata",
    "Lusambo",
    "Luvungi",
    "Lwamba",
    "Lwiza",
    "Mambasa",
    "Manono",
    "Masi-Manimba",
    "Matadi",
    "Mbanza-Ngungu",
    "Mbuji-Mayi",
    "Minembwe",
    "Moba",
    "Mokala",
    "Mokuba",
    "Mongala",
    "Monieka",
    "Muene-Ditu",
    "Mufunga-Sampwe",
    "Mweka",
    "Mwilambongo",
    "Ndjili",
    "Ngandajika",
    "Niangara",
    "Nyunzu",
    "Opala",
    "Oubangi",
    "Pweto",
    "Ruzizi",
    "Rutshuru",
    "Saint-Paul",
    "Sampwe",
    "Sandoa",
    "Sankuru",
    "Shabunda",
    "Shonga",
    "Sona Bata",
    "Soweto",
    "Tambauka",
    "Tshikapa",
    "Tshinvulu",
    "Walungu",
    "Watsa",
    "Yasa-Bonga",
    "Zongo"
  ];

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
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        title: Text(
          'NOUVELLE AGENCE BAUDOUIN',
          textAlign: TextAlign.center,
        ),
        content: Container(
          height: newHeight,
          width: newWidth,
          padding:
              const EdgeInsets.only(left: 60, right: 60, top: 40, bottom: 40),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    decoration: _getInputDecoration("PROVINCE"),
                    controller: provinceController,
                    readOnly: true, // Permet l'édition directe du texte
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ce champ est requis';
                      }
                      return null;
                    },
                    onTap: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        context: context,
                        isScrollControlled:
                            true, // Permet à la feuille de bas d'écran d'utiliser toute la hauteur disponible
                        builder: (context) {
                          return SingleChildScrollView(
                            // Utilisez SingleChildScrollView pour permettre le défilement si nécessaire
                            child: Container(
                              height: newHeight,
                              width: newWidth,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: provinces.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(provinces[index]),
                                    onTap: () {
                                      setState(() {
                                        selectedValue = provinces[index];
                                        provinceController.text = selectedValue;
                                      });
                                      Navigator.of(context)
                                          .pop(); // Ferme la feuille de bas d'écran
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    decoration: _getInputDecoration('VILLE OU AUTRE ENTITE'),

                    controller: villeController,
                    readOnly: true, // Permet l'édition directe du texte
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ce champ est requis';
                      }
                      return null;
                    },
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ), // Permet à la feuille de bas d'écran d'utiliser toute la hauteur disponible
                        builder: (context) {
                          return SingleChildScrollView(
                            // Utilisez SingleChildScrollView pour permettre le défilement si nécessaire
                            child: Container(
                              height: newHeight,
                              width: newWidth,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: villesRDC.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(villesRDC[index]),
                                    onTap: () {
                                      setState(() {
                                        selectedValue = villesRDC[index];
                                        villeController.text = selectedValue;
                                      });
                                      Navigator.of(context)
                                          .pop(); // Ferme la feuille de bas d'écran
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
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
            child: const Text(
              'Annuler',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold
              ),
              ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text(
              'Ajouter',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                bool success = await ajouterAgence(
                  provinceController.text.trim(),
                  villeController.text.trim(),
                  adresseController.text.trim(),
                );

                if (success) {
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            const Text('Erreur lors de l\'ajout de l\'agence')),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
// Reste du code...

Future<bool> ajouterAgence(
    String province, String ville, String adresse) async {
  try {
    final configDocRef =
        FirebaseFirestore.instance.collection('config').doc('lastAgenceId');
    DocumentSnapshot lastIdDoc = await configDocRef.get();

    // Vérifier si le document existe et si lastAgenceId est un entier
    int lastId = lastIdDoc.exists && lastIdDoc.data() != null
        ? (lastIdDoc.data() as Map<String, dynamic>)['lastAgenceId'] ?? 0
        : 0;

    int newId = lastId + 1;

    // Affecter un agent de transfert en fonction du nom
    String agentId = await assignTransferAgent("Baudouin");

    final collectionRef = FirebaseFirestore.instance.collection('agences');
    await collectionRef.add({
      'id': newId.toString(), // Convertir l'ID en une valeur de texte
      'nom': "Baudouin",
      'province': province,
      'ville': ville,
      'adresse': adresse,
      'agentId': agentId,
    });

    // Mettre à jour la dernière valeur d'ID dans le document de configuration
    await configDocRef.set({'lastAgenceId': newId}, SetOptions(merge: true));

    print('Agence ajoutée avec succès');
    return true;
  } catch (e) {
    print('Erreur lors de l\'ajout de l\'agence : $e');
    return false;
  }
}

Future<String> assignTransferAgent(String nom) async {
  // Logique pour affecter un agent de transfert en fonction du nom
  // Remplacez cette logique par la vôtre
  // Par exemple, vous pouvez requêter une base de données ou utiliser une autre source de données pour obtenir l'agent approprié
  // Pour l'instant, nous retournerons un agent fictif avec un ID statique
  await Future.delayed(
      Duration(seconds: 2)); // Simulation d'une requête asynchrone
  return 'agent123';
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
    suffixIcon: Icon(Icons.arrow_drop_down),
  );
}
