import 'package:agence_transfert/configurations/constants/app_texts.dart';
import 'package:agence_transfert/configurations/constants/color_constants.dart';
import 'package:agence_transfert/configurations/constants/utils.dart';
import 'package:agence_transfert/login/admin/login_form.dart';
import 'package:flutter/material.dart';

class LoginAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 800,
          height: 400,
          child: Card(
            surfaceTintColor: Colors.transparent,
            color: AppColors.customColor,
            shadowColor: AppColors.loginShadowColor,
            elevation: 8,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: [getLoginFormWidget(), getBrandLogoWidget()],
            ),
          ),
        ),
      ),
    );
  }

  Widget getLoginFormWidget() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(50),
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: LoginForm(),
        ),
      ),
    );
  }

  Widget getBrandLogoWidget() {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'AGENCE BAUDOUIN',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'LA COLOMBE',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                add24VerticalSpace(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    AppTexts.splashTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.loginSubtextColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
