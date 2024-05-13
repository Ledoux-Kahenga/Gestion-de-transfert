import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:agence_transfert/configurations/constants/utils.dart';
import 'package:agence_transfert/screens/main/menu/agence.dart';
import 'package:flutter/material.dart';
import 'package:agence_transfert/screens/main/dashboard_screen.dart';
import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:agence_transfert/controllers/MenuAppController.dart';
import 'package:provider/provider.dart';

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
    final menuAppController =
        Provider.of<MenuAppController>(context, listen: false);
    return Drawer(
      backgroundColor: Colors.white70,
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppTexts.appName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    AppTexts.lacolombe,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            ),
          ),
          add16VerticalSpace(),
          Container(
            color: _selectedItemIndex == 0
                ? AppColors.customColor
                : Colors.transparent,
            child: ListTile(
              title: Text(
                AppTexts.agence,
                style: TextStyle(
                  fontSize: 18,
                  color: _selectedItemIndex == 0
                      ? AppColors.themeColor
                      : Colors.black.withOpacity(0.6),
                  // color: Colors.black.withOpacity(0.6),
                  // add16HorizontalSpace(),
                ),
              ),
              onTap: () {
                // menuAppController.controlMenu();
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
                ? AppColors.customColor
                : const Color.fromARGB(0, 77, 14, 14),
            child: ListTile(
              title: Text(
                AppTexts.agent,
                style: TextStyle(
                  fontSize: 18,
                  color: _selectedItemIndex == 1
                      ? AppColors.themeColor
                      : Colors.black.withOpacity(0.6),
                ),
              ),
              onTap: () {
                // menuAppController.controlMenu();
                setState(() {
                  _selectedItemIndex = 1;
                  widget.onItemSelected(
                      GestionAgencesPage()); // Navigation vers la page Transactions
                });
              },
              selected: _selectedItemIndex == 1,
            ),
          ),

          Container(
            color: _selectedItemIndex == 2
                ? AppColors.customColor
                : const Color.fromARGB(0, 77, 14, 14),
            child: ListTile(
              title: Text(
                AppTexts.logout,
                style: TextStyle(
                  fontSize: 18,
                  color: _selectedItemIndex == 2
                      ? AppColors.themeColor
                      : Colors.black.withOpacity(0.6),
                ),
              ),
              onTap: () {
                // menuAppController.controlMenu();
                setState(() {
                  _selectedItemIndex = 2;
                  widget.onItemSelected(
                      GestionAgencesPage()); // Navigation vers la page Transactions
                });
              },
              selected: _selectedItemIndex == 2,
            ),
          ),

          // Ajoutez d'autres éléments de menu ici
        ],
      ),
    );
  }
}
