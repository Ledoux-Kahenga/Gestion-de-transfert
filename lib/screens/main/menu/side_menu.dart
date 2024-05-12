import 'package:agence_transfert/configurations/constants/app_texts.dart';
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
    final menuAppController = Provider.of<MenuAppController>(context, listen: false);
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppTexts.appName),
                  Text(AppTexts.lacolombe),
                ],
              ),
            ),
          ),
          Container(
            color: _selectedItemIndex == 0? AppColors.customColor : Colors.transparent,
            child: ListTile(
              title: Text(AppTexts.agence),
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
            color: _selectedItemIndex == 1? AppColors.customColor : Colors.transparent,
            child: ListTile(
              title: Text(AppTexts.agent),
              onTap: () {
                // menuAppController.controlMenu();
                setState(() {
                  _selectedItemIndex = 1;
                  widget.onItemSelected(GestionAgencesPage()); // Navigation vers la page Transactions
                });
              },
              selected: _selectedItemIndex == 1,
            ),
          ),
          // Ajoutez d'autres éléments de menu ici
        ],
      ),
    );
  }
}