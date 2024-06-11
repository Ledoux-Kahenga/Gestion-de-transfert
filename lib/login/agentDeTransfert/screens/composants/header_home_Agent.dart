import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:agence_transfert/login/admin/screens/main/composants/dialog_agence.dart';
import 'package:flutter/material.dart';
import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderAgent extends StatelessWidget {
  // final GlobalKey<DialogAgenceState> dialogKey;
  
    

  // Header({Key? key}) : super(key: key);
  

//  Header({required GlobalKey<DialogAgenceState> dialogKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundWhite,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "AGENCES BAUDOUIN KOLWEZI",
              style: TextStyle(
                  color: AppColors.textColorBlack,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Spacer(), // Ajoutez un Spacer pour pousser les widgets vers la droite
          Padding(
            padding: EdgeInsets.all(
                8), // Ajoutez de la marge sur tous les côtés de SearchField
            // child: SearchField(),
          ),
          Padding(
            padding: EdgeInsets.all(
                8), // Ajoutez de la marge sur tous les côtés de ProfileCard
            child: ProfileCard(),
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: AppTexts.defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: AppTexts.defaultPadding,
        vertical: AppTexts.defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile_pic.png",
            height: 38,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppTexts.defaultPadding / 2),
            child: Text(
              "Angelina Jolie",
              style: TextStyle(color: AppColors.textColorBlack),
            ),
          ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
 
  }
}

