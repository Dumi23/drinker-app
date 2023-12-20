import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gout/api/api.dart';
import 'package:gout/language/appLocalizations.dart';
import 'package:gout/providers/theme_provider.dart';
import 'package:gout/routes/route_names.dart';
import 'package:gout/utils/localfiles.dart';
import 'package:gout/utils/text_styles.dart';
import 'package:gout/utils/themes.dart';
import 'package:gout/widgets/bottom_top_move_animation_view.dart';
import 'package:provider/provider.dart';
import '../../models/setting_list_data.dart';

class ProfileScreen extends StatefulWidget {
  final AnimationController animationController;

  const ProfileScreen({Key? key, required this.animationController})
      : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<SettingsListData> userSettingsList = SettingsListData.userSettingsList;
  late User me = User(username: "Guest", email: "Guest@mail.com", location: "empty", music: [], type: 0);
  late String? imageURL = ""; 
  @override
  void initState() {
    print(userSettingsList.length);
    fetchMe().then((value) {
      setState(() {
        me = value;
        imageURL = value.image;
        print(me);
        if (me.type == 1 && userSettingsList.length < 4) {
          userSettingsList.add(SettingsListData(
              titleTxt: "Create a Place",
              iconData: FontAwesomeIcons.beerMugEmpty));
        }
      });
    });
    widget.animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  return BottomTopMoveAnimationView(
        animationController: widget.animationController,
        child: Consumer<ThemeProvider>(
          builder: (context, provider, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Container(child: appBar(imageURL, me)),
              ),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(0.0),
                  itemCount: userSettingsList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        //setting screen view
                        if (index == 2) {
                          NavigationServices(context).gotoSettingsScreen(me);

                          //   setState(() {});
                        }
                        //help center screen view

                        if (index == 3) {
                          NavigationServices(context).goToCreatePlaceScreen();
                        }
                        //Chage password  screen view

                        if (index == 0) {
                          NavigationServices(context)
                              .gotoChangepasswordScreen();
                        }
                        //Invite friend  screen view

                        if (index == 1) {
                          NavigationServices(context).gotoInviteFriend();
                        }
                      },
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 16),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      userSettingsList[index].titleTxt,
                                      style: TextStyles(context)
                                          .getRegularStyle()
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Container(
                                    child: Icon(
                                        userSettingsList[index].iconData,
                                        color: AppTheme.secondaryTextColor
                                            .withOpacity(0.7)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Divider(
                              height: 1,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }

  Widget appBar(imageURL, User me) {
    if (imageURL == null){
      imageURL = "https://www.mtsolar.us/wp-content/uploads/2020/04/avatar-placeholder.png";
    } else{
      imageURL = "https://5cw4rvtc-8000.euw.devtunnels.ms${imageURL}";
    }
    return InkWell(
      onTap: () {
        NavigationServices(context).gotoEditProfile(me);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    me.username,
                    style: new TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    AppLocalizations(context).of("view_edit"),
                    style: new TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 24, top: 16, bottom: 16, left: 24),
            child: Container(
              width: 70,
              height: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                child: Image.network(imageURL),
              ),
            ),
          )
        ],
      ),
    );
  }
}
