import 'package:flutter/material.dart';
import 'package:agence_transfert/controllers/MenuAppController.dart';
import 'package:agence_transfert/screens/main/pages/agence_home.dart';
import 'package:agence_transfert/screens/main/menu/side_menu.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _currentPage = DashboardScreen();
  late MenuAppController menuAppController;

  void _changePage(Widget page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  void initState() {
    super.initState();
    menuAppController =
        MenuAppController(); // Initialisation de menuAppController
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: SideMenu(
              onItemSelected: _changePage,
              menuAppController: menuAppController,
            ),
          ),
          Expanded(
            flex: 8,
            child: _currentPage,
          ),
        ],
      ),
    );
  }
}
