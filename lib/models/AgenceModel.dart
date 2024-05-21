class AgenceModel {
  final String id;
  final String province;
  final String ville;
  final String adresse;

  AgenceModel({required this.id, required this.province, required this.ville, required this.adresse});

  factory AgenceModel.fromMap(Map<String, dynamic> map) {
    return AgenceModel(
      id: map['id'],
      province: map['province'],
      ville: map['ville'],
      adresse: map['adresse'],
    );
  }
}