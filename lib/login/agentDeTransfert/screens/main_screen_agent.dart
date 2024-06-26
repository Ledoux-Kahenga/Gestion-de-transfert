import 'package:agence_transfert/login/agentDeTransfert/screens/pages/DashboardAgent.dart';
import 'package:flutter/material.dart';
import 'package:agence_transfert/controllers/MenuAppController.dart';
import 'package:agence_transfert/login/admin/screens/main/pages/DashboardCreationAgence.dart';
import 'package:agence_transfert/login/agentDeTransfert/screens/menu/side_menu_agent.dart';


class MainScreenAgent extends StatefulWidget {

   late String agenceNom;
   late String nom;
   late String agenceId;
   late String password;
    MainScreenAgent({required this.agenceNom, required this.nom, required this.agenceId, required this.password});

    // late Widget widget;

  
  @override
  _MainScreenAgentState createState() => _MainScreenAgentState();
}

class _MainScreenAgentState extends State<MainScreenAgent> {
  late Widget _currentPage ;
  late MenuAppController menuAppController;

  void _changePage(Widget page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentPage = DashboardAgentScreen(agenceNom: widget.agenceNom, nom: widget.nom, agenceId: widget.agenceId,password: widget.password);
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
            child: SideMenuAgent(
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
