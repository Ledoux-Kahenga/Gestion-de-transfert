import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:agence_transfert/login/admin/screens/main/composants/agenceDialog.dart';
import 'package:agence_transfert/login/admin/screens/main/composants/dialog_agent.dart';
import 'package:agence_transfert/login/agentDeTransfert/screens/composants/dialog_envoyer.dart';
import 'package:agence_transfert/login/agentDeTransfert/screens/composants/dialog_recevoir.dart';
import 'package:agence_transfert/login/agentDeTransfert/screens/composants/footerAgent.dart';
import 'package:agence_transfert/login/agentDeTransfert/screens/composants/header_home_Agent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:agence_transfert/constants.dart';
import 'package:agence_transfert/login/admin/screens/main/composants/header_home.dart';

class DashboardAgentScreen extends StatefulWidget {
  late String agenceNom;
  late String nom;
  late String agenceId;

  DashboardAgentScreen({required this.agenceNom, required this.nom, required this.agenceId});

  @override
  _DashboardAgentScreenState createState() => _DashboardAgentScreenState();
}

class _DashboardAgentScreenState extends State<DashboardAgentScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double screenHeight = constraints.maxHeight;
        double dashboardHeight = screenHeight;
        return Container(
          child: Scaffold(
              body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: AppColors.backgroundWhite,
                height: 70,
                margin: EdgeInsets.only(left: 2, top: 1, right: 2),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "HOME",
                        style: TextStyle(
                            color: AppColors.textColorBlack,
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                      Container(
                        // margin: EdgeInsets.only(left: AppTexts.defaultPadding),
                        padding: EdgeInsets.symmetric(
                          horizontal: AppTexts.defaultPadding,
                          vertical: AppTexts.defaultPadding / 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/profile_pic.png",
                              height: 38,
                            ),
                            Text(
                              widget.nom,
                              style: TextStyle(color: AppColors.textColorBlack),
                            ),
                            Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8, top: 8, right: 8),
                child: Row(

                  children: [
                    Column(

                      children: [
                        Card(
                          color: Colors.white,
                          surfaceTintColor: Colors.transparent,
                          shadowColor: Color.fromARGB(255, 243, 220, 204),
                          elevation: 4,
                          child: Container(
                            // margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                              border: Border.all(color: Colors.black12),
                            ),
                            // color: AppColors.backgroundWhite,
                            width: 600,
                            height: 100,
                            child: Center(
                              child: Text(
                                widget.agenceNom,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: AppColors.textColorBlack,
                                    fontWeight: FontWeight.w100),
                                // textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              child: Card(
                                color: Colors.white,
                                surfaceTintColor: Colors.transparent,
                                shadowColor: Color.fromARGB(255, 243, 220, 204),
                                elevation: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DialogEnvoyer(
                                            agenceNom: widget.agenceNom,
                                            nom: widget.nom,
                                            agenceId: widget.agenceId,
                                          );
                                        });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      // border: Border.all(color: Colors.blue, width: 2),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/images/envoyer.png',
                                          height: 100.0,
                                          width: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                        Text(
                                          "Envoyer",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: AppColors.textColorBlack,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 200,
                              child: Card(
                                color: Colors.white,
                                surfaceTintColor: Colors.transparent,
                                shadowColor: Color.fromARGB(255, 243, 220, 204),
                                elevation: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    // border: Border.all(color: Colors.blue, width: 2),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/transactions.png',
                                        height: 100.0,
                                        width: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        "Transactions",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: AppColors.textColorBlack,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                           GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DialogRecevoir(
                                            agenceNom: widget.agenceNom,
                                            nom: widget.nom,
                                            agenceId: widget.agenceId,
                                          );
                                        });
                                  },
                              child: Container(
                                height: 200,
                                width: 200,
                                child: Card(
                                  color: Colors.white,
                                  surfaceTintColor: Colors.transparent,
                                  shadowColor: Color.fromARGB(255, 243, 220, 204),
                                  elevation: 4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      // border: Border.all(color: Colors.blue, width: 2),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/images/recevoir.png',
                                          height: 100.0,
                                          width: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                        Text(
                                          "Recevoir",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: AppColors.textColorBlack,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              child: Card(
                                color: Colors.white,
                                surfaceTintColor: Colors.transparent,
                                shadowColor: Color.fromARGB(255, 243, 220, 204),
                                elevation: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    // border: Border.all(color: Colors.blue, width: 2),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/service1.png',
                                        height: 100.0,
                                        width: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        "Services",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: AppColors.textColorBlack,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 200,
                              child: Card(
                                color: Colors.white,
                                surfaceTintColor: Colors.transparent,
                                shadowColor: Color.fromARGB(255, 243, 220, 204),
                                elevation: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    // border: Border.all(color: Colors.blue, width: 2),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/compte.png',
                                        height: 100.0,
                                        width: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        "Compte agence",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: AppColors.textColorBlack,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 200,
                              child: Card(
                                color: Colors.white,
                                surfaceTintColor: Colors.transparent,
                                shadowColor: Color.fromARGB(255, 243, 220, 204),
                                elevation: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    // border: Border.all(color: Colors.blue, width: 2),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/seting.png',
                                        height: 100.0,
                                        width: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        "Parametres",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: AppColors.textColorBlack,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 510,
                      width: 460.200,
                      child: const Card(
                        color: Colors.white,
                        surfaceTintColor: Colors.transparent,
                        shadowColor: Color.fromARGB(255, 243, 220, 204),
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "Activités recentes",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: AppColors.textColorBlack),
                                textAlign: TextAlign.center,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8, left: 2, bottom: 2, right: 2),
                child: FooterAgent(),
              )
            ],
          )),
        );
      },
    );
  }
}
