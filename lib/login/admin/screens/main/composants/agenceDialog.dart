import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:flutter/material.dart';

class DialogOption extends StatefulWidget {
  // final String province;
  // final String ville;
  // final String adresse;

  // DialogOption({
  //   required this.province,
  //   required this.ville,
  //   required this.adresse,
  // });

  @override
  _DialogOptionState createState() => _DialogOptionState();
}

class _DialogOptionState extends State<DialogOption> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController villeController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
    // provinceController = TextEditingController(text: widget.province);
    // villeController = TextEditingController(text: widget.ville);
    // adresseController = TextEditingController(text: widget.adresse);
  // }

  // @override
  // void dispose() {
  //   provinceController.dispose();
  //   villeController = TextEditingController();
  //   adresseController.dispose();
  //   super.dispose();
  // }


 void _showAgenceDetails(Map<String, dynamic> agenceData) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Détails de l\'agence'),
        content: Container(
          width: 600, // Ajustez la largeur du dialog selon vos besoins
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: provinceController..text = agenceData['province'],
                decoration: InputDecoration(
                  labelText: 'Province',
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: villeController..text = agenceData['ville'],
                decoration: InputDecoration(
                  labelText: 'Ville',
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: adresseController..text = agenceData['adresse'],
                decoration: InputDecoration(
                  labelText: 'Adresse',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Fermer'),
          ),
          TextButton(
            onPressed: () {
              // Logique de mise à jour des informations de l'agence
              Navigator.of(context).pop();
            },
            child: Text('Sauvegarder'),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var newWidth = width - width * .50;
    var newHeight = height > 500.0 ? 500.0 : height;

    return AlertDialog(
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
            'MODIFIER AGENCE',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ],
      ),
      content: Container(
        height: newHeight,
        width: newWidth,
        padding: const EdgeInsets.only(left: 60, right: 60, top: 40, bottom: 40),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: provinceController,
                  decoration: InputDecoration(
                    fillColor: const Color(0xffF6F8FB).withOpacity(0.5),
                    filled: true,
                    border: const OutlineInputBorder(),
                    label: Text(
                      "PROVINCE",
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une province';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: villeController,
                  decoration: InputDecoration(
                    fillColor: const Color(0xffF6F8FB).withOpacity(0.5),
                    filled: true,
                    border: const OutlineInputBorder(),
                    label: Text(
                      "VILLE",
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une ville';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
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
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une adresse';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Logique de sauvegarde des modifications
                        if (_formKey.currentState!.validate()) {
                          // Récupérer les nouvelles valeurs
                          String newProvince = provinceController.text;
                          String newVille = villeController.text;
                          String newAdresse = adresseController.text;

                          // Faire quelque chose avec les nouvelles valeurs (enregistrer dans la base de données, par exemple)
                          print('Nouvelle province : $newProvince');
                          print('Nouvelle ville : $newVille');
                          print('Nouvelle adresse : $newAdresse');

                          // Fermer le dialogue
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('Enregistrer'),
                    ),
                    SizedBox(width: 8.0),
                    OutlinedButton(
                      onPressed: () {
                        // Fermer le dialogue sans sauvegarder
                        Navigator.of(context).pop();
                      },
                      child: Text('Annuler'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}