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
        surfaceTintColor: Colors.white,
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
                        "assets/images/logo.png",
                       
                        height: 136, // Spécifiez la largeur souhaitée
                        // Flutter ajustera la hauteur pour maintenir les proportions
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                // padding: EdgeInsets.only(left: 20),
                color: _selectedItemIndex == 0
                    ? AppColors.background
                    : Colors.transparent,
                child: ListTile(
                  leading: SvgPicture.asset('assets/icons/agence.svg', width: 16),
                  title: Text(
                    AppTexts.menuHome,
                    style: TextStyle(
                      fontSize: 18,
                      color: _selectedItemIndex == 0
                          ? AppColors.textColorBlack
                          : Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.bold
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedItemIndex = 0;
                      widget.onItemSelected(DashboardAgentScreen());
                    });
                  },
                  selected: _selectedItemIndex == 0,
                ),
              ),
              Container(
                color: _selectedItemIndex == 1
                    ? AppColors.background
                    : const Color.fromARGB(0, 77, 14, 14),
                child: ListTile(
                  leading: SvgPicture.asset('assets/icons/transaction.svg', width: 18,),
                  title: Text(
                    AppTexts.menuTransaction,
                    style: TextStyle(
                      fontSize: 18,
                      color: _selectedItemIndex == 1
                          ? AppColors.textColorBlack
                          : Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.bold
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedItemIndex = 1;
                      widget.onItemSelected(GestionAgentsPage());
                    });
                  },
                  selected: _selectedItemIndex == 1,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 2),
                color: _selectedItemIndex == 2
                    ? AppColors.background
                    : const Color.fromARGB(0, 77, 14, 14),
                child: ListTile(
                  leading: SvgPicture.asset('assets/icons/logout2.svg', width: 20),
                  title: Text(
                    AppTexts.menuHistorique,
                    style: TextStyle(
                      fontSize: 18,
                      color: _selectedItemIndex == 2
                          ? AppColors.textColorBlack
                          : Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.bold
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedItemIndex = 2;
                      widget.onItemSelected(LoginAdmin());
                    });
                  },
                  selected: _selectedItemIndex == 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
