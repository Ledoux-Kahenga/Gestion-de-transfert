import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:agence_transfert/login/admin/login_admin.dart';
// import 'package:agence_transfert/screens/main/menu/agence.dart';
// import 'package:agence_transfert/screens/main/menu/agent.dart';
import 'package:agence_transfert/login/admin/screens/main/pages/CreationAgent_transferts.dart';
import 'package:agence_transfert/login/agentDeTransfert/screens/pages/DashboardAgent.dart';
import 'package:flutter/material.dart';
import 'package:agence_transfert/login/admin/screens/main/pages/DashboardCreationAgence.dart';
import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:agence_transfert/controllers/MenuAppController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

// import 'package:provider/provider.dart';

class SideMenuAgent extends StatefulWidget {
  final Function(Widget) onItemSelected;
  final MenuAppController menuAppController;

  const SideMenuAgent({
    Key? key,
    required this.onItemSelected,
    required this.menuAppController,
  }) : super(key: key);

  @override
  _SideMenuAgentState createState() => _SideMenuAgentState();
}

class _SideMenuAgentState extends State<SideMenuAgent> {
  int _selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final menuAppController =
    //     Provider.of<MenuAppController>(context, listen: false);
    return Container(
      color: AppColors.backgroundWhite,
      child: Drawer(
        // surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        child: Center(
          // Ajout de Center pour centrer le contenu du Drawer
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 136,
                      ),
                    ],
                  ),
                ),
              ),
              // Container(
              //   // padding: EdgeInsets.only(left: 20),
              //   color: _selectedItemIndex == 0
              //       ? AppColors.background
              //       : Colors.transparent,
              //   child: Center(
              //     child: ListTile(
              //       enabled: false,
              //       leading:
              //           SvgPicture.asset('assets/icons/agence.svg', width: 16),
              //       title: Text(
              //         AppTexts.menuHome,
              //         style: TextStyle(
              //             fontSize: 18,
              //             color: _selectedItemIndex == 0
              //                 ? AppColors.textColorBlack
              //                 : Colors.black.withOpacity(0.6),
              //             fontWeight: FontWeight.bold),
              //       ),
              //       onTap: () {
              //         setState(() {
              //           _selectedItemIndex = 0;
              //           widget.onItemSelected(DashboardAgentScreen(
              //             agenceNom: '',
              //             nom: '',
              //             agenceId: "",
              //             password: "",
              //           ));
              //         });
              //       },
              //       selected: _selectedItemIndex == 0,
              //     ),
              //   ),
              // ),
             
              50.height,
              Container(
                 
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'COMPTE',
                        style: boldTextStyle(size: 16),
                      ),
                      8.height,
                      Text(
                        '123 Rue de la Paix\n75000 Paris, France',
                        style: secondaryTextStyle(size: 14),
                      ),
                      16.height,
                      Text(
                        'Tél. : +33 1 23 45 67 89',
                        style: secondaryTextStyle(size: 14),
                      ),
                    ],
                  )),
            
            ],
          ),
        ),
      ),
    );
  }
}
