import 'package:flutter/material.dart';
import 'package:gout/utils/localfiles.dart';
import 'package:gout/utils/text_styles.dart';
import 'package:gout/utils/themes.dart';
import 'package:gout/language/appLocalizations.dart';
import 'package:gout/providers/theme_provider.dart';
import 'package:gout/routes/route_names.dart';
import 'package:gout/widgets/common_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoadText = false;
  var navigation;
  @override
  void initState() {
    var sharedPrefs = SharedPreferences.getInstance();
    sharedPrefs.then((value) {
      if (value.get('loggedIn') == true) {
        {NavigationServices(context).gotoTabScreen();}
      }
      else {
        navigation = CommonButton(
          padding:
              const EdgeInsets.only(left: 48, right: 48, bottom: 8, top: 8),
          buttonText: "Log in",
          onTap: () {
            NavigationServices(context).gotoLoginScreen();
          },
        );
      }
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        _loadAppLocalizations()); // call after first frame receiver so we have context
    super.initState();
  }

  Future<void> _loadAppLocalizations() async {
    try {
      //load all text json file to allLanguageTextData(in common file)
      //   await AppLocalizations.init(context);
      setState(() {
        isLoadText = true;
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeProvider>(context);
    return Container(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              foregroundDecoration: !appTheme.isLightMode
                  ? BoxDecoration(
                      color: Theme.of(context).backgroundColor.withOpacity(0.4))
                  : null,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(Localfiles.party, fit: BoxFit.cover),
            ),
            Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Theme.of(context).dividerColor,
                            offset: Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      child: Image.asset(Localfiles.logo),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "GOUT",
                  textAlign: TextAlign.left,
                  style: TextStyles(context).getBoldStyle().copyWith(
                        fontSize: 24,
                      ),
                ),
                SizedBox(
                  height: 8,
                ),
                AnimatedOpacity(
                  opacity: isLoadText ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 420),
                  child: Text(
                    "Plan your perfect night out",
                    textAlign: TextAlign.left,
                    style: TextStyles(context).getRegularStyle().copyWith(),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: SizedBox(),
                ),
                AnimatedOpacity(
                    opacity: isLoadText ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 680),
                    child: navigation),
                AnimatedOpacity(
                  opacity: isLoadText ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 1200),
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: 24.0 + MediaQuery.of(context).padding.bottom,
                        top: 16),
                    child: InkWell(
                      onTap: () {
                        NavigationServices(context).gotoSignScreen();
                      },
                      child: Text(
                        "Don't have an account, Sign Up",
                        textAlign: TextAlign.left,
                        style:
                            TextStyles(context).getDescriptionStyle().copyWith(
                                  color: AppTheme.whiteColor,
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
