import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:agence_transfert/login/admin/screens/main/composants/dialog_agence.dart';
import 'package:flutter/material.dart';
import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

class FooterAgent extends StatelessWidget {
  // final GlobalKey<DialogAgenceState> dialogKey;

  // Header({Key? key}) : super(key: key);

//  Header({required GlobalKey<DialogAgenceState> dialogKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      color: AppColors.backgroundWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Adresse de l\'agence',
            style: boldTextStyle(),
          ),
          8.height,
          Text(
            '123 Rue de la Paix, C/ Annexe',
            style: secondaryTextStyle(),
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
