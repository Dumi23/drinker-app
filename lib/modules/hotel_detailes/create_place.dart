import 'package:flutter/material.dart';
import 'package:gout/utils/text_styles.dart';
import 'package:gout/utils/themes.dart';
import 'package:gout/language/appLocalizations.dart';
import 'package:gout/modules/login/facebook_twitter_button_view.dart';
import 'package:gout/routes/route_names.dart';
import 'package:gout/utils/validator.dart';
import 'package:gout/widgets/common_appbar_view.dart';
import 'package:gout/widgets/common_button.dart';
import 'package:gout/widgets/common_text_field_view.dart';
import 'package:gout/widgets/remove_focuse.dart';
import 'package:gout/api/api.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CreatePlace extends StatefulWidget {

  const CreatePlace({Key? key,}) : super(key: key);

  @override
  _EditPlaceScreenState createState() => _EditPlaceScreenState();
}

class _EditPlaceScreenState extends State {
  List location = [
    {
      "type": "Brcko",
      "id": "KDGbL",
    },
    {
      "type": "Novi Sad",
      "id": "ELMyL",
    },
  ];

  String _errorEmail = '';
  TextEditingController _emailController = TextEditingController();
  String _errorPassword = '';
  TextEditingController _passwordController = TextEditingController();
  String _errorFName = '';
  TextEditingController _fnameController = TextEditingController();
  String _errorLName = '';
  TextEditingController _lnameController = TextEditingController();
  List<Music> musicSlug = [];
  int type = 0;

  List<String> formMusicSlug(List<Music> music) {
    List<String> musicSlug = [];
    music.forEach((e) => musicSlug.add(e.slug));
    print(musicSlug);
    return musicSlug;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: RemoveFocuse(
          onClick: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _appBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                      ),
                      CommonTextFieldView(
                        controller: _fnameController,
                        errorText: _errorFName,
                        padding: const EdgeInsets.only(
                            bottom: 16, left: 24, right: 24),
                        titleText: "Username",
                        hintText: "enter your username",
                        keyboardType: TextInputType.name,
                        onChanged: (String txt) {},
                      ),
                      CommonTextFieldView(
                        controller: _emailController,
                        errorText: _errorEmail,
                        titleText: "Name",
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 16),
                        hintText:
                            "Name of the Locale",
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (String txt) {},
                      ),
                      CommonTextFieldView(
                        titleText: "Description",
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 24),
                        hintText:
                            "Description of the Locale",
                        isObscureText: true,
                        onChanged: (String txt) {},
                        errorText: _errorPassword,
                        controller: _passwordController,
                      ),
                      SizedBox(
                          width: 475,
                          child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: DropdownSearch<Music>.multiSelection(
                                popupProps: const PopupPropsMultiSelection.menu(
                                  showSelectedItems: false,
                                  showSearchBox: true,
                                ),
                                asyncItems: (String filter) =>
                                    fetchMusic(filter),
                                itemAsString: (Music music) => music.genre,
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                  labelText: "Music",
                                )),
                                // ignore: avoid_print
                                onChanged: (value) {
                                  setState(() {
                                    musicSlug = value;
                                    print(musicSlug);
                                  });
                                },
                              ))),
                      SizedBox(
                          width: 475,
                          child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: DropdownSearch<dynamic>(
                                popupProps: const PopupPropsMultiSelection.menu(
                                  showSelectedItems: false,
                                  showSearchBox: false,
                                ),
                                items: location,
                                itemAsString: (item) => (item['type']),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                  labelText: "User Type",
                                )),
                                // ignore: avoid_print
                                onChanged: (value) {
                                  type = value['id'];
                                },
                              ))),
                      CommonButton(
                        padding:
                            EdgeInsets.only(left: 24, right: 24, bottom: 8),
                        buttonText: AppLocalizations(context).of("sign_up"),
                        onTap: () {
                          if (_allValidation()) {
                            print(formMusicSlug(musicSlug));
                            CreateAccountDTO data = CreateAccountDTO(
                                email: _emailController.text.toString(),
                                password: _passwordController.text.toString(),
                                username: _fnameController.text.toString(),
                                music_slug: formMusicSlug(musicSlug),
                                type: type);
                            createAccount(data).then((value) {
                              var snackBar = SnackBar(content: Text(value));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            });
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          AppLocalizations(context).of("terms_agreed"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            AppLocalizations(context)
                                .of("already_have_account"),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).disabledColor,
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            onTap: () {
                              NavigationServices(context).gotoLoginScreen();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "Create",
                                style: TextStyles(context)
                                    .getRegularStyle()
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primaryColor,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 24,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return CommonAppbarView(
      iconData: Icons.arrow_back,
      titleText: AppLocalizations(context).of("sign_up"),
      onBackClick: () {
        Navigator.pop(context);
      },
    );
  }

  bool _allValidation() {
    bool isValid = true;

    if (_fnameController.text.trim().isEmpty) {
      _errorFName = "Username cannot be empty";
      isValid = false;
    } else {
      _errorFName = '';
    }

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
    } else if (_passwordController.text.trim().length < 8) {
      _errorPassword = AppLocalizations(context).of('valid_password');
      isValid = false;
    } else {
      _errorPassword = '';
    }
    setState(() {});
    return isValid;
  }
}
