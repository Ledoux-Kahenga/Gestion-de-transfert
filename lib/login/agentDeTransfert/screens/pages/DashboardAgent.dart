import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:agence_transfert/login/admin/screens/main/composants/agenceDialog.dart';
import 'package:agence_transfert/login/admin/screens/main/composants/dialog_agent.dart';
import 'package:agence_transfert/login/agentDeTransfert/screens/composants/dialog_envoyer.dart';
import 'package:agence_transfert/login/agentDeTransfert/screens/composants/dialog_recevoir.dart';
import 'package:agence_transfert/login/agentDeTransfert/screens/composants/dialog_transactions.dart';
import 'package:agence_transfert/login/agentDeTransfert/screens/composants/footerAgent.dart';
import 'package:agence_transfert/login/agentDeTransfert/screens/composants/header_home_Agent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:agence_transfert/constants.dart';
import 'package:agence_transfert/login/admin/screens/main/composants/header_home.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import '../composants/dialog_message.dart';
import 'dart:async' as async;

import 'package:flutter_badged/badge_position.dart';
import 'package:flutter_badged/badge_positioned.dart';
import 'package:flutter_badged/flutter_badge.dart';

// import 'dart:nativewrappers/_internal/vm/lib/async_patch.dart' as async_patch;

class DashboardAgentScreen extends StatefulWidget {
  late String agenceNom;
  late String nom;
  late String agenceId;
  late String password;
  // final Function(Widget) onItemSelected;

  DashboardAgentScreen(
      {required this.agenceNom,
      required this.nom,
      required this.agenceId,
      required this.password});

  @override
  _DashboardAgentScreenState createState() => _DashboardAgentScreenState();
}

class _DashboardAgentScreenState extends State<DashboardAgentScreen> {
  int? _selectedSegment;

  Stream<QuerySnapshot>? _transfersStream;
  int _selectedItemIndex = 0;

  @override
  void initState() {
    // _transfersFuture = FirebaseFirestore.instance.collection('transfers').get();
    super.initState();
    _selectedSegment = 0;
    _transfersStream = getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance.collection('transfers').snapshots();
  }

  Stream<int> getTransferCountStream() {
    return FirebaseFirestore.instance
        .collection('transfers')
        .where('destinationAgencyName', isEqualTo: widget.agenceNom)
        .where('statusTransfert', isEqualTo: 'En cours')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .length); // Convertit chaque snapshot en le nombre de documents
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double screenHeight = constraints.maxHeight;
        double dashboardHeight = screenHeight;
        return Container(
          child: Scaffold(
              backgroundColor: AppColors.background,
              body: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: double.infinity,
                      width: 300,
                      color: AppColors.backgroundWhite,
                      child: Column(children: [
                        50.height,
                        Container(
                            height: 600,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('AGENCE BAUDOUIN',
                                    style: boldTextStyle(size: 18)),
                                4.height,
                                Text(
                                  'LA COLOMBE',
                                  style: secondaryTextStyle(size: 16),
                                ),
                                50.height,
                                Divider(),
                                Container(
                                  height: 400,
                                  child: ListView(
                                    children: [
                                      Container(
                                        // padding: EdgeInsets.only(left: 20),
                                        color: _selectedItemIndex == 0
                                            ? AppColors.itmeSelected
                                            : Colors.transparent,
                                        child: Center(
                                          child: ListTile(
                                            leading: SvgPicture.asset(
                                                'assets/icons/home.svg',
                                                width: 16),
                                            title: Text(
                                              'Acceuil',
                                              style: boldTextStyle(
                                                color: _selectedItemIndex == 0
                                                    ? AppColors.textColorBlack
                                                    : Colors.black
                                                        .withOpacity(0.6),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                _selectedItemIndex = 0;
                                                // widget.onItemSelected( )
                                              });
                                            },
                                            selected: _selectedItemIndex == 0,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // padding: EdgeInsets.only(left: 20),
                                        color: _selectedItemIndex == 1
                                            ? AppColors.itmeSelected
                                            : Colors.transparent,
                                        child: Center(
                                          child: ListTile(
                                            leading: SvgPicture.asset(
                                                'assets/icons/paper-plane.svg',
                                                width: 16),
                                            title: Text(
                                              'Envoi de fonds',
                                              style: boldTextStyle(
                                                color: _selectedItemIndex == 1
                                                    ? AppColors.textColorBlack
                                                    : Colors.black
                                                        .withOpacity(0.6),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                _selectedItemIndex = 1;
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return DialogEnvoyer(
                                                        agenceNom:
                                                            widget.agenceNom,
                                                        nom: widget.nom,
                                                        agenceId:
                                                            widget.agenceId,
                                                        password:
                                                            widget.password,
                                                      );
                                                    });
                                              });
                                            },
                                            selected: _selectedItemIndex == 1,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // padding: EdgeInsets.only(left: 20),
                                        color: _selectedItemIndex == 2
                                            ? AppColors.itmeSelected
                                            : Colors.transparent,
                                        child: Center(
                                          child: ListTile(
                                            leading: SvgPicture.asset(
                                                'assets/icons/envelope-dot.svg',
                                                width: 16),
                                            title: Text(
                                              'Retrait de fonds',
                                              style: boldTextStyle(
                                                color: _selectedItemIndex == 2
                                                    ? AppColors.textColorBlack
                                                    : Colors.black
                                                        .withOpacity(0.6),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                _selectedItemIndex = 2;
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return DialogRecevoir(
                                                        agenceNom:
                                                            widget.agenceNom,
                                                        nom: widget.nom,
                                                        agenceId:
                                                            widget.agenceId,
                                                        password:
                                                            widget.password,
                                                      );
                                                    });
                                              });
                                            },
                                            selected: _selectedItemIndex == 2,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // padding: EdgeInsets.only(left: 20),
                                        color: _selectedItemIndex == 3
                                            ? AppColors.itmeSelected
                                            : Colors.transparent,
                                        child: Center(
                                          child: ListTile(
                                            leading: SvgPicture.asset(
                                                'assets/icons/priority-arrows.svg',
                                                width: 16),
                                            title: Text(
                                              'Transactions',
                                              style: boldTextStyle(
                                                color: _selectedItemIndex == 3
                                                    ? AppColors.textColorBlack
                                                    : Colors.black
                                                        .withOpacity(0.6),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                _selectedItemIndex = 3;
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return DialogTransaction(
                                                        agenceNom:
                                                            widget.agenceNom,
                                                        nom: widget.nom,
                                                        agenceId:
                                                            widget.agenceId,
                                                        password:
                                                            widget.password,
                                                      );
                                                    });
                                              });
                                            },
                                            selected: _selectedItemIndex == 3,
                                          ),
                                        ),
                                      ),
                                      14.height,
                                      Divider(),
                                      Container(
                                        // padding: EdgeInsets.only(left: 20),
                                        color: _selectedItemIndex == 4
                                            ? AppColors.itmeSelected
                                            : Colors.transparent,
                                        child: Center(
                                          child: ListTile(
                                            leading: SvgPicture.asset(
                                                'assets/icons/calculator-math-tax.svg',
                                                width: 16),
                                            title: Text(
                                              'Relevés bancaires',
                                              style: boldTextStyle(
                                                color: _selectedItemIndex == 4
                                                    ? AppColors.textColorBlack
                                                    : Colors.black
                                                        .withOpacity(0.6),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                _selectedItemIndex = 4;
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return DialogMessage(
                                                        agenceNom:
                                                            widget.agenceNom,
                                                        nom: widget.nom,
                                                        agenceId:
                                                            widget.agenceId,
                                                        password:
                                                            widget.password,
                                                      );
                                                    });
                                              });
                                            },
                                            selected: _selectedItemIndex == 4,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // padding: EdgeInsets.only(left: 20),
                                        color: _selectedItemIndex == 5
                                            ? AppColors.itmeSelected
                                            : Colors.transparent,
                                        child: Center(
                                          child: ListTile(
                                            leading: SvgPicture.asset(
                                                'assets/icons/briefcase.svg',
                                                width: 16),
                                            title: Text(
                                              'Compte agence',
                                              style: boldTextStyle(
                                                color: _selectedItemIndex == 5
                                                    ? AppColors.textColorBlack
                                                    : Colors.black
                                                        .withOpacity(0.6),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                _selectedItemIndex = 5;
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return DialogMessage(
                                                        agenceNom:
                                                            widget.agenceNom,
                                                        nom: widget.nom,
                                                        agenceId:
                                                            widget.agenceId,
                                                        password:
                                                            widget.password,
                                                      );
                                                    });
                                              });
                                            },
                                            selected: _selectedItemIndex == 5,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // padding: EdgeInsets.only(left: 20),
                                        color: _selectedItemIndex == 6
                                            ? AppColors.itmeSelected
                                            : Colors.transparent,
                                        child: Center(
                                          child: ListTile(
                                            leading: SvgPicture.asset(
                                                'assets/icons/settings.svg',
                                                width: 16),
                                            title: Text(
                                              'Parametres',
                                              style: boldTextStyle(
                                                color: _selectedItemIndex == 6
                                                    ? AppColors.textColorBlack
                                                    : Colors.black
                                                        .withOpacity(0.6),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                _selectedItemIndex = 6;
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return DialogMessage(
                                                        agenceNom:
                                                            widget.agenceNom,
                                                        nom: widget.nom,
                                                        agenceId:
                                                            widget.agenceId,
                                                        password:
                                                            widget.password,
                                                      );
                                                    });
                                              });
                                            },
                                            selected: _selectedItemIndex == 6,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ]),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: AppColors.backgroundWhite,
                          height: 70,
                          margin: EdgeInsets.only(
                              left: 4, bottom: 2, top: 1, right: 4),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "TABLEAU DE BORD",
                                  style: boldTextStyle(size: 26),
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 200,
                                          height: 50,
                                          child: AppTextField(
                                            controller:
                                                TextEditingController(), // Optional
                                            textFieldType: TextFieldType.OTHER,
                                            decoration: InputDecoration(
                                              labelText: 'Recherche',
                                              suffixIcon: Icon(Icons.search),
                                            ),
                                          ),
                                        ),

                                        10.width,

                                        // SvgPicture.asset(
                                        //   "assets/icons/envelope.svg",
                                        // ),
                                      ],
                                    ),
                                    10.width,
                                    Container(
                                      // margin: EdgeInsets.only(left: AppTexts.defaultPadding),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppTexts.defaultPadding,
                                        vertical: AppTexts.defaultPadding / 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(6)),
                                        border:
                                            Border.all(color: Colors.black12),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/profile_pic.png",
                                            height: 38,
                                          ),
                                          5.width,
                                          Text(widget.nom,
                                              style:
                                                  primaryTextStyle(size: 16)),
                                          Icon(Icons.keyboard_arrow_down),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 2, bottom: 0, right: 2),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  2.height,
                                  Card(
                                    color: Colors.white,
                                    surfaceTintColor: Colors.transparent,
                                    shadowColor:
                                        Color.fromARGB(255, 243, 220, 204),
                                    elevation: 1,
                                    margin: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Container(
                                      // margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4)),
                                        // border: Border.all(color: Colors.black12),
                                      ),
                                      // color: AppColors.backgroundWhite,
                                      width: 590,
                                      height: 126,
                                      child: Center(
                                        child: Text(
                                            widget.agenceNom.toUpperCase(),
                                            style: boldTextStyle(size: 20)
                                            // textAlign: TextAlign.center,
                                            ),
                                      ),
                                    ),
                                  ),
                                  2.height,
                                  Row(
                                    children: [
                                      Container(
                                        height: 194,
                                        width: 194,
                                        margin: EdgeInsets.all(2),
                                        child: Card(
                                          color: Colors.white,
                                          surfaceTintColor: Colors.transparent,
                                          shadowColor: Color.fromARGB(
                                              255, 243, 220, 204),
                                          elevation: 1,
                                          margin: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return DialogEnvoyer(
                                                      agenceNom:
                                                          widget.agenceNom,
                                                      nom: widget.nom,
                                                      agenceId: widget.agenceId,
                                                      password: widget.password,
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 2,
                                                  bottom: 2,
                                                  top: 2,
                                                  right: 2),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(1),
                                                // border: Border.all(color: Colors.blue, width: 2),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/envoyer.png',
                                                    height: 100.0,
                                                    width: 100.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Text("Envoi de fonds",
                                                      style: boldTextStyle()),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 194,
                                        width: 194,
                                        margin: EdgeInsets.all(2),
                                        child: Card(
                                          color: Colors.white,
                                          surfaceTintColor: Colors.transparent,
                                          shadowColor: Color.fromARGB(
                                              255, 243, 220, 204),
                                          elevation: 1,
                                          margin: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return DialogTransaction(
                                                      agenceNom:
                                                          widget.agenceNom,
                                                      nom: widget.nom,
                                                      agenceId: widget.agenceId,
                                                      password: widget.password,
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 2,
                                                  bottom: 2,
                                                  top: 2,
                                                  right: 2),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(1),
                                                // border: Border.all(color: Colors.blue, width: 2),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/transactions.png',
                                                    height: 100.0,
                                                    width: 100.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Text("Transactions",
                                                      style: boldTextStyle())
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 194,
                                        width: 194,
                                        margin: EdgeInsets.all(2),
                                        child: Card(
                                          color: Colors.white,
                                          surfaceTintColor: Colors.transparent,
                                          shadowColor: Color.fromARGB(
                                              255, 243, 220, 204),
                                          elevation: 1,
                                          margin: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return DialogRecevoir(
                                                      agenceNom:
                                                          widget.agenceNom,
                                                      nom: widget.nom,
                                                      agenceId: widget.agenceId,
                                                      password: widget.password,
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 2,
                                                  bottom: 2,
                                                  top: 2,
                                                  right: 2),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(1),
                                                // border: Border.all(color: Colors.blue, width: 2),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Stack(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .topEnd,
                                                      children: [
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 20,
                                                                    bottom: 20),
                                                            child:
                                                                StreamBuilder<
                                                                    int>(
                                                              stream:
                                                                  getTransferCountStream(),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasError) {
                                                                  return Text(
                                                                      'Error: ${snapshot.error}');
                                                                }

                                                                if (snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .waiting) {
                                                                  return CircularProgressIndicator(); // Ou un autre widget de chargement
                                                                }

                                                                final count = snapshot
                                                                        .data ??
                                                                    0; // Utilisez snapshot.data pour obtenir le compteur

                                                                return count > 0
                                                                    ? FlutterBadge(
                                                                        icon: SvgPicture
                                                                            .asset(
                                                                          "assets/icons/bell.svg",
                                                                          height:
                                                                              24.0,
                                                                        ),
                                                                        itemCount:
                                                                            count,
                                                                        borderRadius:
                                                                            100,
                                                                      )
                                                                    : SvgPicture
                                                                        .asset(
                                                                        "assets/icons/bell.svg",
                                                                        height:
                                                                            24.0,
                                                                      );
                                                              },
                                                            )),
                                                        Image.asset(
                                                          'assets/images/recevoir.png',
                                                          height: 100.0,
                                                          width: 100.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ]),
                                                  Text("Reception de fonds",
                                                      style: boldTextStyle())
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // 2.width,
                                  2.height,
                                  Row(
                                    children: [
                                      Container(
                                        height: 194,
                                        width: 194,
                                        margin: EdgeInsets.all(2),
                                        child: Card(
                                          color: Colors.white,
                                          surfaceTintColor: Colors.transparent,
                                          shadowColor: Color.fromARGB(
                                              255, 243, 220, 204),
                                          elevation: 1,
                                          margin: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return DialogMessage(
                                                      agenceNom:
                                                          widget.agenceNom,
                                                      nom: widget.nom,
                                                      agenceId: widget.agenceId,
                                                      password: widget.password,
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(1),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/service1.png',
                                                    height: 100.0,
                                                    width: 100.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Text("Relevés de comptes",
                                                      style: boldTextStyle()),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 194,
                                        width: 194,
                                        margin: EdgeInsets.all(2),
                                        child: Card(
                                          color: Colors.white,
                                          surfaceTintColor: Colors.transparent,
                                          shadowColor: Color.fromARGB(
                                              255, 243, 220, 204),
                                          elevation: 1,
                                          margin: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return DialogMessage(
                                                      agenceNom:
                                                          widget.agenceNom,
                                                      nom: widget.nom,
                                                      agenceId: widget.agenceId,
                                                      password: widget.password,
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(1),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/compte.png',
                                                    height: 100.0,
                                                    width: 100.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Text("Compte de l'agence",
                                                      style: boldTextStyle()),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 194,
                                        width: 194,
                                        margin: EdgeInsets.all(2),
                                        child: Card(
                                          color: Colors.white,
                                          surfaceTintColor: Colors.transparent,
                                          shadowColor: Color.fromARGB(
                                              255, 243, 220, 204),
                                          elevation: 1,
                                          margin: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return DialogMessage(
                                                      agenceNom:
                                                          widget.agenceNom,
                                                      nom: widget.nom,
                                                      agenceId: widget.agenceId,
                                                      password: widget.password,
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(1),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/seting.png',
                                                    height: 100.0,
                                                    width: 100.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Text("Paramètres",
                                                      style: boldTextStyle()),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // 2.height,
                                ],
                              ),
                              Container(
                                height: 524,
                                width: 490,
                                margin: EdgeInsets.only(
                                    left: 2, bottom: 2, right: 2),
                                child: Card(
                                  color: Colors.white,
                                  surfaceTintColor: Colors.transparent,
                                  shadowColor:
                                      Color.fromARGB(255, 243, 220, 204),
                                  elevation: 1,
                                  margin: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Activités recentes",
                                          style: boldTextStyle(size: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                        Divider(),
                                        Container(
                                          height: 420,
                                          child: Column(
                                            children: [
                                              Center(
                                                child: Container(
                                                  height: 420,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CupertinoSlidingSegmentedControl<
                                                          int>(
                                                        children: {
                                                          0: Text('Tous'),
                                                          1: Text('Envoyés'),
                                                          2: Text('Retirés'),
                                                        },
                                                        groupValue:
                                                            _selectedSegment,
                                                        onValueChanged:
                                                            (int? value) {
                                                          setState(() {
                                                            _selectedSegment =
                                                                value;
                                                          });
                                                        },
                                                      ),
                                                      // SizedBox(height: 20),
                                                      Flexible(
                                                        fit: FlexFit.loose,
                                                        // Utilisez Expanded pour que le contenu prenne tout l'espace restant
                                                        child:
                                                            _getContentBasedOnSegment(), // Appelez la méthode ici
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 2, left: 4, bottom: 2, right: 4),
                          child: FooterAgent(),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }

  Widget _getContentBasedOnSegment() {
    switch (_selectedSegment) {
      case 0:
        return Container(
            child: StreamBuilder<QuerySnapshot>(
          stream: _transfersStream,
          builder: (context, snapshot) {
            final documents = snapshot.data?.docs ?? [];

            final filteredTransfers = documents
                .where((doc) =>
                    (doc['destinationAgencyName'] == widget.agenceNom ||
                        doc['statusTransfert'] == 'En cours') &&
                    (doc['statusTransfert'] == 'Retirer' ||
                        doc['origineAgencyName'] == widget.agenceNom))
                .toList();

            DateFormat dateFormat = DateFormat('dd/MM/yyyy à HH:mm');
            filteredTransfers.sort((a, b) => (b['temps'].toDate()).compareTo(a['temps'].toDate()));

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
                              'De: ${transfer['origineAgencyName']}',
                              style: primaryTextStyle(weight: FontWeight.bold),
                            )
                          else
                            Text(
                              'À: ${transfer['destinationAgencyName']}',
                              style: primaryTextStyle(weight: FontWeight.bold),
                            ),
                        ],
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Beneficiaire: ${transfer['beneficiaryName']}',
                            style: secondaryTextStyle(),
                          ),
                          Text(
                            'Code de retrait: ${transfer['codeRetrait']}',
                            style: secondaryTextStyle(),
                          ),
                          Text(
                            'Montant: ${transfer['montant']}',
                            style: secondaryTextStyle(),
                          ),
                          if (transfer['statusTransfert'] == 'Retirer')
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Envoyé le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['date']))} à ${transfer['heure']}',
                                  style: secondaryTextStyle(),
                                ),
                                Text(
                                  'Retiré le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['dateRetrait']))} à ${transfer['heureRetrait']}',
                                  style: secondaryTextStyle(),
                                ),
                                //  Icon(Icons.arrow_right, size: 16.0),
                              ],
                            )
                          else
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Envoyé le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['date']))} à ${transfer['heure']}',
                                    style: secondaryTextStyle(),
                                  ),
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

      case 1:
        return Container(
            child: StreamBuilder<QuerySnapshot>(
          stream: _transfersStream,
          builder: (context, snapshot) {
            final documents = snapshot.data?.docs ?? [];

            final filteredTransfers = documents
                .where((doc) =>
                    doc['origineAgencyName'] == widget.agenceNom &&
                    doc['statusTransfert'] == 'En cours')
                .toList();

                DateFormat dateFormat = DateFormat('dd/MM/yyyy à HH:mm');
            filteredTransfers.sort((a, b) => (b['temps'].toDate()).compareTo(a['temps'].toDate()));

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
                              'De: ${transfer['origineAgencyName']}',
                              style: primaryTextStyle(weight: FontWeight.bold),
                            )
                          else
                            Text('À: ${transfer['destinationAgencyName']}',
                                style:
                                    primaryTextStyle(weight: FontWeight.bold)),
                        ],
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Beneficiaire: ${transfer['beneficiaryName']}',
                              style: secondaryTextStyle()),
                          Text('Code de retrait: ${transfer['codeRetrait']}',
                              style: secondaryTextStyle()),
                          Text('Montant: ${transfer['montant']}',
                              style: secondaryTextStyle()),
                          if (transfer['statusTransfert'] == 'Retirer')
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Envoyé le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['date']))} à ${transfer['heure']}',
                                    style: secondaryTextStyle()),
                                Text(
                                    'Retiré le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['dateRetrait']))} à ${transfer['heureRetrait']}',
                                    style: secondaryTextStyle()),
                                //  Icon(Icons.arrow_right, size: 16.0),
                              ],
                            )
                          else
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Envoyé le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['date']))} à ${transfer['heure']}',
                                      style: secondaryTextStyle()),
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
                              onPressed: () async {},
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
                              onPressed: () async {},
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
            child: StreamBuilder<QuerySnapshot>(
          stream: _transfersStream,
          builder: (context, snapshot) {
            final documents = snapshot.data?.docs ?? [];

            final filteredTransfers = documents
                .where((doc) =>
                    doc['destinationAgencyName'] == widget.agenceNom &&
                    doc['statusTransfert'] == 'Retirer')
                .toList();

                DateFormat dateFormat = DateFormat('dd/MM/yyyy à HH:mm');
            filteredTransfers.sort((a, b) => (b['temps'].toDate()).compareTo(a['temps'].toDate()));

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
                            Text('De: ${transfer['origineAgencyName']}',
                                style:
                                    primaryTextStyle(weight: FontWeight.bold))
                          else
                            Text('À: ${transfer['destinationAgencyName']}',
                                style:
                                    primaryTextStyle(weight: FontWeight.bold)),
                        ],
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Beneficiaire: ${transfer['beneficiaryName']}',
                              style: secondaryTextStyle()),
                          Text('Code de retrait: ${transfer['codeRetrait']}',
                              style: secondaryTextStyle()),
                          Text('Montant: ${transfer['montant']}',
                              style: secondaryTextStyle()),
                          if (transfer['statusTransfert'] == 'Retirer')
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Envoyé le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['date']))} à ${transfer['heure']}',
                                  style: secondaryTextStyle(),
                                ),
                                Text(
                                    'Retiré le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['dateRetrait']))} à ${transfer['heureRetrait']}',
                                    style: secondaryTextStyle()),
                                //  Icon(Icons.arrow_right, size: 16.0),
                              ],
                            )
                          else
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Envoyé le ${DateFormat('dd/MM/yyyy').format(DateTime.parse(transfer['date']))} à ${transfer['heure']}',
                                      style: secondaryTextStyle()),
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
                              onPressed: () async {},
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
        return Center(child: Text('Aucun segment sélectionné'));
    }
  }
}
