import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:agence_transfert/login/admin/login_admin.dart';
// import 'package:agence_transfert/screens/main/menu/agence.dart';
// import 'package:agence_transfert/screens/main/menu/agent.dart';
import 'package:agence_transfert/screens/main/pages/agent_transferts.dart';
import 'package:flutter/material.dart';
import 'package:agence_transfert/screens/main/pages/agence_home.dart';
import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:agence_transfert/controllers/MenuAppController.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';

class SideMenu extends StatefulWidget {
  final Function(Widget) onItemSelected;
  final MenuAppController menuAppController;

  const SideMenu({
    Key? key,
    required this.onItemSelected,
    required this.menuAppController,
  }) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
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
                        width: 200, // Spécifiez la largeur souhaitée
                        // Flutter ajustera la hauteur pour maintenir les proportions
                      ),
                      Text(
                        AppTexts.appName,
                        style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
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
                    AppTexts.agence,
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
                      widget.onItemSelected(DashboardScreen());
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
                  leading: SvgPicture.asset('assets/icons/user1.svg', width: 20,),
                  title: Text(
                    AppTexts.agent,
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
                    AppTexts.logout,
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
