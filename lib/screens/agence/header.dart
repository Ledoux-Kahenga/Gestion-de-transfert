import 'package:flutter/material.dart';
import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(8), // Ajoutez de la marge sur tous les côtés de SearchField
            child: SearchField(),
          ),
          Padding(
            padding: EdgeInsets.all(8), // Ajoutez de la marge sur tous les côtés de ProfileCard
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
      margin: EdgeInsets.only(left: AppTexts.defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: AppTexts.defaultPadding,
        vertical: AppTexts.defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
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
            child: Text("Angelina Jolie"),
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
      width: 420, // Spécifiez la largeur du Container à 320 pixels
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          fillColor: Colors.black,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(AppTexts.defaultPadding * 0.75),
              margin: EdgeInsets.symmetric(horizontal: AppTexts.defaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: SvgPicture.asset("assets/icons/Search.svg"),
            ),
          ),
        ),
      ),
    );
  }
}