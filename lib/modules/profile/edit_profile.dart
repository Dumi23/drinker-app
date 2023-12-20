import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gout/api/api.dart';
import 'package:gout/language/appLocalizations.dart';
import 'package:gout/utils/localfiles.dart';
import 'package:gout/utils/text_styles.dart';
import 'package:gout/utils/themes.dart';
import 'package:gout/widgets/common_appbar_view.dart';
import 'package:gout/widgets/common_card.dart';
import 'package:gout/widgets/remove_focuse.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/setting_list_data.dart';

class EditProfile extends StatefulWidget {
  late User me;

  EditProfile({Key? key, required this.me}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    var userInfo = userInfoList(widget.me);
    var imageURL;
    if (widget.me.image == null){
      imageURL = "https://www.mtsolar.us/wp-content/uploads/2020/04/avatar-placeholder.png";
    } else {
      imageURL = "https://5cw4rvtc-8000.euw.devtunnels.ms${widget.me.image.toString()}";
    }
    return Container(
      child: Scaffold(
        backgroundColor: AppTheme.scaffoldBackgroundColor,
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
                titleText: AppLocalizations(context).of("edit_profile"),
                onBackClick: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(
                      bottom: 16 + MediaQuery.of(context).padding.bottom),
                  itemCount: userInfo.toList().length,
                  itemBuilder: (context, index) {
                    return index == 0
                        ? getProfileUI(imageURL)
                        : InkWell(
                            onTap: () {},
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 16),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0, bottom: 16, top: 16),
                                          child: Text(
                                            userInfo.toList()[index].subTxt,
                                            style: TextStyles(context)
                                                .getDescriptionStyle()
                                                .copyWith(
                                                  fontSize: 16,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 16.0, bottom: 16, top: 16),
                                        child: Container(
                                          child: Text(
                                            userInfo.toList()[index].titleTxt,
                                            style: TextStyles(context)
                                                .getRegularStyle()
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
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
        ),
      ),
    );
  }

  Widget getProfileUI(imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 130,
            height: 130,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Theme.of(context).dividerColor,
                        blurRadius: 8,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(60.0)),
                    child: Image.network(imageUrl),
                  ),
                ),
                Positioned(
                  bottom: 6,
                  right: 6,
                  child: CommonCard(
                    color: AppTheme.primaryColor,
                    radius: 36,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        onTap: () async {
                          final source = await ImageSource.gallery;
                          final pickedImage = await ImagePicker().pickImage(source: source);
                          updateUserPic(pickedImage!.path);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.camera_alt,
                            color: Theme.of(context).backgroundColor,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
