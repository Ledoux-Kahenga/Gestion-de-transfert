import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:agence_transfert/login/admin/screens/main/composants/dialog_agence.dart';
import 'package:flutter/material.dart';
import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
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
              "AGENCES",
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
            padding: EdgeInsets.all(8),
            child: Container(
              child: Container(
                margin: EdgeInsets.only(left: 32),
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                      return DialogAgence();
                      });
                    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/add.svg',
                        width: 18,
                        height: 18,
                        color: AppColors.backgroundWhite,
                      ),
                      const Text(
                        AppTexts.add,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
              "Admin",
              style: TextStyle(color: AppColors.textColorBlack),
            ),
          ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Spécifiez la largeur du Container à 320 pixels
      child: Card(
        shadowColor: AppColors.loginShadowColor,
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              6), // Augmentez le rayon pour un effet plus prononcé
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Recherche",
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: const BorderRadius.all(Radius.circular(
                  6)), // Assurez-vous que le rayon est le même ici
            ),
            suffixIcon: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(AppTexts.defaultPadding * 0.75),
                margin: EdgeInsets.symmetric(
                    horizontal: AppTexts.defaultPadding / 2),
                decoration: BoxDecoration(
                  color: AppColors.textColorBlack,
                  borderRadius: const BorderRadius.all(Radius.circular(
                      4)), // Assurez-vous que le rayon est le même ici
                ),
                child: SvgPicture.asset("assets/icons/Search.svg"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
