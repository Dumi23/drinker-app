import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gout/language/appLocalizations.dart';
import 'package:gout/modules/login/facebook_twitter_button_view.dart';
import 'package:gout/routes/route_names.dart';
import 'package:gout/utils/themes.dart';
import 'package:gout/utils/validator.dart';
import 'package:gout/widgets/common_appbar_view.dart';
import 'package:gout/widgets/common_button.dart';
import 'package:gout/widgets/common_text_field_view.dart';
import 'package:gout/widgets/remove_focuse.dart';
import 'package:gout/api/api.dart';
import 'package:dropdown_search/dropdown_search.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _errorEmail = '';
  TextEditingController _emailController = TextEditingController();
  String _errorPassword = '';
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.arrow_back,
              titleText: AppLocalizations(context).of("login"),
              onBackClick: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Log in with your credentials",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                    CommonTextFieldView(
                      controller: _emailController,
                      errorText: _errorEmail,
                      titleText: AppLocalizations(context).of("your_mail"),
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 16),
                      hintText:
                          AppLocalizations(context).of("enter_your_email"),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (String txt) {},
                    ),
                    CommonTextFieldView(
                      titleText: AppLocalizations(context).of("password"),
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      hintText: AppLocalizations(context).of("enter_password"),
                      isObscureText: true,
                      onChanged: (String txt) {},
                      errorText: _errorPassword,
                      controller: _passwordController,
                    ),
                    _forgotYourPasswordUI(),
                    CommonButton(
                      padding: EdgeInsets.only(left: 24, right: 24, bottom: 16),
                      buttonText: AppLocalizations(context).of("login"),
                      onTap: () {
                        if (_allValidation()) {
                          LoginDTO data = LoginDTO(
                              email: _emailController.text.toString(),
                              password: _passwordController.text.toString());
                          login(data).then((value) {
                            setState(() {
                              if (value == "Welcome. Succesfuly logged in") {
                                var snackBar = SnackBar(
                                    content: Text(
                                      value,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: AppTheme.backgroundColor);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                NavigationServices(context).gotoTabScreen();
                              } else {
                                var snackBar = SnackBar(content: Text(value));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            });
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _forgotYourPasswordUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 16, bottom: 8, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            onTap: () {
              NavigationServices(context).gotoTabScreen();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Continue as Guest",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _allValidation() {
    bool isValid = true;
    if (_emailController.text.trim().isEmpty) {
      _errorEmail = AppLocalizations(context).of('email_cannot_empty');
      isValid = false;
    } else if (!Validator.validateEmail(_emailController.text.trim())) {
      _errorEmail = AppLocalizations(context).of('enter_valid_email');
      isValid = false;
    } else {
      _errorEmail = '';
    }

    if (_passwordController.text.trim().isEmpty) {
      _errorPassword = AppLocalizations(context).of('password_cannot_empty');
      isValid = false;
    } else if (_passwordController.text.trim().length < 6) {
      _errorPassword = AppLocalizations(context).of('valid_password');
      isValid = false;
    } else {
      _errorPassword = '';
    }
    setState(() {});
    return isValid;
  }
}
