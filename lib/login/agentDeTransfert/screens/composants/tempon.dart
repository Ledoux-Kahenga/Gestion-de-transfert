// import 'package:agence_transfert/configurations/constants/color_constants.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class DialogRecevoir extends StatefulWidget {
//   late String agenceNom;
//   late String nom;
//   late String agenceId;
//   late String password;

//   DialogRecevoir(
//       {required this.agenceNom,
//       required this.nom,
//       required this.agenceId,
//       required this.password});

//   @override
//   _DialogRecevoirState createState() => _DialogRecevoirState();
// }

// class _DialogRecevoirState extends State<DialogRecevoir> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController passeWordAgent = TextEditingController();
//   late Future<QuerySnapshot> _transfersFuture;

//   @override
//   void initState() {
//     _transfersFuture = FirebaseFirestore.instance.collection('transfers').get();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     passeWordAgent.dispose();
//     super.dispose();
//   }

//   String origineAgencyId() {
//     return widget.agenceId;
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     var newWidth = width - width * .50;
//     var newHeight = height > 500.0 ? 500.0 : height;
//     return AlertDialog(
//       backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
//       surfaceTintColor: Colors.transparent,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(10.0),
//         ),
//       ),
//       title: Column(
//         children: [
//           Text(
//             'RECEPTION DE FONDS',
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
//           ),
//           Text(
//             'AGENCE ${widget.agenceNom.toUpperCase()}',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//         ],
//       ),
//       // content: FutureBuilder<QuerySnapshot<Object?>>(
        
//       //   future: _transfersFuture,
//       //   builder: (context, snapshot) {

//           // final documents = snapshot.data?.docs ?? [];

//           // final filteredTransfers = documents
//           //     .where((doc) =>
//           //         doc['destinationAgencyName'] == widget.agenceNom &&
//           //         doc['statusTransfert'] == 'En cours')
//           //     .toList();
              
//           // if (snapshot.connectionState == ConnectionState.waiting) {
//           //   return Container(
//           //     height: newHeight,
//           //     width: newWidth,
//           //   );
//           // }

//           // if (snapshot.hasError) {
//           //   return Container(
//           //     height: newHeight,
//           //     width: newWidth,
//           //     child: Text(
//           //       'Erreur: ${snapshot.error}',
//           //       style: TextStyle(color: Colors.red),
//           //     ),
//           //   );
//           // }

          

//           // if (filteredTransfers.isEmpty) {
//           //   return Container(
//           //     height: newHeight,
//           //     width: newWidth,
//           //     child: Column(
//           //       mainAxisAlignment: MainAxisAlignment.center,
//           //       children: [
//           //         Container(
//           //           height: 230,
//           //           padding: EdgeInsets.all(32),
//           //           child: Image.asset('assets/images/boxvide.png'),
//           //           decoration: BoxDecoration(
//           //             color: Colors.grey.withOpacity(0.2),
//           //             shape: BoxShape.circle,
//           //           ),
//           //         ),
//           //         SizedBox(height: 70),
//           //         Text("LA BOITE DE RECEPTION EST VIDE"),
//           //       ],
//           //     ),
//           //   );
//           // }

//       //     // Filtrer les transferts pour ne garder que ceux destinés à l'agence courante
          

//       //     return Container(
//       //       height: newHeight,
//       //       width: newWidth,
//       //       child: ListView.builder(
//       //         itemCount: filteredTransfers.length,
//       //         itemBuilder: (context, index) {
//       //           final transfer = filteredTransfers[index];
//       //           return Column(
//       //             children: [
//       //               Divider(),
//       //               ListTile(
//       //                   // ... (reste du code)
//       //                   ),
//       //               Divider()
//       //             ],
//       //           );
//       //         },
//       //       ),
//       //     );
//       //   },
//       // ),
      
//        content: FutureBuilder<QuerySnapshot>(
//         future: _transfersFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Container(
//               height: newHeight,
//               width: newWidth,
//               child: Text(
//                 'Erreur: ${snapshot.error}',
//                 style: TextStyle(color: Colors.red),
//               ),
//             );
//           }
//           if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
//             return Container(
//               height: newHeight,
//               width: newWidth,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 230,
//                     padding: EdgeInsets.all(32),
//                     child: Image.asset('assets/images/boxvide.png'),
//                     decoration: BoxDecoration(
//                         color: Colors.grey.withOpacity(0.2),
//                         shape: BoxShape.circle),
//                   ),
//                   SizedBox(
//                     height: 70,
//                   ),
//                   Text("LA BOITE DE RECEPTION EST VIDE")
//                 ],
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Container(
//               height: newHeight,
//               width: newWidth,
//               child: Text(
//                 'Erreur: ${snapshot.error}',
//                 style: TextStyle(color: Colors.red),
//               ),
//             );
//           } else {
//             // Filtrer les transferts pour ne garder que ceux destinés à l'agence courante
//             List<DocumentSnapshot> filteredTransfers = snapshot.data!.docs
//                 .where((doc) =>
//                     doc['destinationAgencyName'] == widget.agenceNom &&
//                     doc['statusTransfert'] == 'En cours')
//                 .toList();

//             return Container(
//               height: newHeight,
//               width: newWidth,
//               child: ListView.builder(
//                 itemCount: filteredTransfers.length,
//                 itemBuilder: (context, index) {
//                   DocumentSnapshot transfer = filteredTransfers[index];
//                   return Column(
//                     children: [
//                       Divider(),
//                       ListTile(
//                           title: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '${transfer['origineAgencyName']}',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 16),
//                               ),
//                               // Text(''),
//                             ],
//                           ),
//                           subtitle: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                   'Beneficiare: ${transfer['beneficiaryName']}'),
//                               Text(
//                                   'Code de retrait: ${transfer['codeRetrait']}'),
//                               Text('Montant: ${transfer['montant']}'),
//                               Text(
//                                 'Envoyé le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['date']))} À ${transfer['heure']}',
//                                 style: TextStyle(fontSize: 14),
//                               ),
//                             ],
//                           ),
//                           trailing: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               TextButton(
//                                 style: TextButton.styleFrom(
//                                   foregroundColor:
//                                       Colors.white, // Couleur du texte
//                                   backgroundColor:
//                                       Colors.blue[300], // Couleur de fond
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 20,
//                                       vertical: 12), // Espacement du texte
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(
//                                         8), // Coins arrondis
//                                   ),
//                                 ),
//                                 child: const Text(
//                                   'Retirer',
//                                   style: TextStyle(
//                                     fontSize: 16, // Taille de la police
//                                   ),
//                                 ),
//                                 onPressed: () async {
//                                   String id = transfer['id'];
//                                   String passeword =
//                                       transfer['destinationPassewordAgent'];
//                                   retirerFond(context, passeword, id);

//                                   print(passeword + " contre" + id);
//                                 },
//                               ),
//                             ],
//                           )),
//                       Divider()
//                     ],
//                   );
//                 },
//               ),
//             );
//           }
//         },
//       ),
     
      
//       actions: <Widget>[
//         TextButton(
//           style: TextButton.styleFrom(
//             foregroundColor: Colors.white, // Couleur du texte
//             backgroundColor: Colors.red, // Couleur de fond
//             padding: EdgeInsets.symmetric(
//                 horizontal: 16, vertical: 12), // Espacement du texte
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(18), // Coins arrondis
//             ),
//           ),
//           child: Text(
//             'Fermer',
//             style: TextStyle(
//               fontSize: 16, // Taille de la police
//             ),
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ],
//     );
//   }

//   // Future<void> retirerFond(
//   //     BuildContext context, String passWord, String transferId) async {
//   //   // String psw = passeWordAgent.text;

//   //   TextFormField(
//   //     controller: passeWordAgent,
//   //     decoration: InputDecoration(
//   //       fillColor: const Color(0xffF6F8FB).withOpacity(0.5),
//   //       filled: true,
//   //       border: const OutlineInputBorder(),
//   //       label: Text(
//   //         "ADRESSE",
//   //         style: const TextStyle(color: Colors.black87),
//   //       ),
//   //       suffixIcon: Icon(Icons.room),
//   //     ),
//   //     validator: (value) {
//   //       if (value!.isEmpty) {
//   //         return 'Ce champ est requis';
//   //       }
//   //       return null;
//   //     },
//   //   );

//   //   if (passeWordAgent.text == passWord) {
//   //     // Mots de passe ne correspondent pas
//   //     showDialog(
//   //       context: context,
//   //       builder: (BuildContext context) {
//   //         return AlertDialog(
//   //           title: Text('Erreur'),
//   //           content: Text('Le mot de passe saisi ne correspond pas.'),
//   //           actions: [
//   //             TextButton(
//   //               onPressed: () {
//   //                 Navigator.of(context).pop();
//   //               },
//   //               child: Text('OK'),
//   //             ),
//   //           ],
//   //         );
//   //       },
//   //     );
//   //     return;

//   //   }

//   //   try {
//   //     // Mettre à jour le statut du transfert dans Firestore
//   //     await FirebaseFirestore.instance
//   //         .collection('transfers').doc(transferId)
//   //         .update({'statusTransfert': "Retirer"});

//   //     // Fermer la boîte de dialogue
//   //     Navigator.of(context).pop();

//   //     // Afficher un message de succès
//   //     showDialog(
//   //       context: context,
//   //       builder: (BuildContext context) {
//   //         return AlertDialog(
//   //           title: Text('Succès'),
//   //           content: Text('Le transfert a été retiré avec succès.'),
//   //           actions: [
//   //             TextButton(
//   //               onPressed: () {
//   //                 Navigator.of(context).pop();
//   //               },
//   //               child: Text('OK'),
//   //             ),
//   //           ],
//   //         );
//   //       },
//   //     );
//   //   } catch (e) {
//   //     // Afficher un message d'erreur
//   //     showDialog(
//   //       context: context,
//   //       builder: (BuildContext context) {
//   //         return AlertDialog(
//   //           title: Text('Erreur'),
//   //           content: Text(
//   //               'Une erreur est survenue lors du retrait du transfert: $e'),
//   //           actions: [
//   //             TextButton(
//   //               onPressed: () {
//   //                 Navigator.of(context).pop();
//   //               },
//   //               child: Text('OK'),
//   //             ),
//   //           ],
//   //         );
//   //       },
//   //     );
//   //   }
//   // }

//   Future<void> retirerFond(
//       BuildContext context, String passWord, String transferId) async {
//     String? enteredPassword = await _promptForPassword(context);

//     if (enteredPassword == null) {
//       // User canceled the operation
//       return;
//     }

//     if (enteredPassword == passWord) {
//       await FirebaseFirestore.instance
//           .collection('transfers')
//           .doc(transferId)
//           .update({'statusTransfert': "Retirer"});
//       await _showMessageSuccusful();
//     } else {
//       // Incorrect password, inform the user and ask again
//       await _showErrorAndRetry(context, passWord, transferId);
//     }
//   }

//   Future<String?> _promptForPassword(BuildContext context) async {
//     String? enteredPassword;
//     return showDialog<String>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Saisir le mot de passe'),
//           content: TextField(
//             obscureText: true, // Ensure the text field obscures the password
//             decoration: InputDecoration(
//               hintText: 'Entrez le mot de passe',
//             ),
//             onChanged: (value) {
//               enteredPassword = value;
//             },
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context)
//                     .pop(enteredPassword); // Pass the entered password back
//               },
//               child: Text('OK'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context)
//                     .pop(null); // Indicate cancellation by popping null
//               },
//               child: Text('Annuler'),
//             ),
//           ],
//         );
//       },
//     ).then((value) =>
//         value); // Wait for the dialog to close and return the entered password or null if canceled
//   }

//   Future<void> _showErrorAndRetry(
//       BuildContext context, String passWord, String transferId) async {
//     // Show error dialog
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: Text('Erreur'),
//         content: Text('Le mot de passe saisi ne correspond pas.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the error dialog
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );

//     // After closing the error dialog, retry asking for the password
//     await retirerFond(context, passWord, transferId);
//   }

//   Future<void> _showMessageSuccusful() async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: Text('Succès'),
//         content: Text('Le Retrait a reussi.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
