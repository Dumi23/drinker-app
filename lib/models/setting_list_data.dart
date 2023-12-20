import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gout/api/api.dart';

List<SettingsListData> userInfoList(User me) {
  return [
    SettingsListData(
      titleTxt: '',
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: me.username,
      subTxt: "Username",
    ),
    SettingsListData(
      titleTxt: me.email,
      subTxt: "Email",
    ),
    SettingsListData(
      titleTxt: me.location,
      subTxt: "Location",
    ),
  ];
}

class SettingsListData {
  String titleTxt;
  String subTxt;
  IconData iconData;
  bool isSelected;

  SettingsListData({
    this.titleTxt = '',
    this.isSelected = false,
    this.subTxt = '',
    this.iconData = Icons.supervised_user_circle,
  });

  List<SettingsListData> getCountryListFromJson(Map<String, dynamic> json) {
    var locationList = [{"name": "Brcko", "slug": "KDGbL"}, {"name": "Novi Sad", "slug": "ELMyL"}];
    List<SettingsListData> locations = [];
    if (locationList != null) {
      locationList.forEach((v) {
        print(locationList);
        SettingsListData data = SettingsListData();
        data.titleTxt = v["name"]!;
        data.subTxt = v['slug']!;
        locations.add(data);
      });
    }
    return locations;
  }

  static List<SettingsListData> userSettingsList = [
    SettingsListData(
      titleTxt: 'Change Password',
      isSelected: false,
      iconData: FontAwesomeIcons.lock,
    ),
    SettingsListData(
      titleTxt: 'Invite a Friend',
      isSelected: false,
      iconData: FontAwesomeIcons.userFriends,
    ),
    SettingsListData(
      titleTxt: 'Settings',
      isSelected: false,
      iconData: FontAwesomeIcons.cog,
    )
  ];
  static List<SettingsListData> settingsList = [
    SettingsListData(
      titleTxt: 'Notifications',
      isSelected: false,
      iconData: FontAwesomeIcons.solidBell,
    ),
    SettingsListData(
      titleTxt: 'Theme Mode',
      isSelected: false,
      iconData: FontAwesomeIcons.skyatlas,
    ),
    SettingsListData(
      titleTxt: 'Fonts',
      isSelected: false,
      iconData: FontAwesomeIcons.font,
    ),
    SettingsListData(
      titleTxt: 'Color',
      isSelected: false,
      iconData: Icons.color_lens,
    ),
    SettingsListData(
      titleTxt: 'Language',
      isSelected: false,
      iconData: Icons.translate_outlined,
    ),
    SettingsListData(
      titleTxt: 'Location',
      isSelected: false,
      iconData: FontAwesomeIcons.userFriends,
    ),
    SettingsListData(
      titleTxt: 'Log out',
      isSelected: false,
      iconData: Icons.keyboard_arrow_right,
    )
  ];

  static List<SettingsListData> currencyList = [
    SettingsListData(
      titleTxt: 'Australia Dollar',
      subTxt: "\$ AUD",
    ),
    SettingsListData(
      titleTxt: 'Argentina Peso',
      subTxt: "\$ ARS",
    ),
    SettingsListData(
      titleTxt: 'Indian rupee',
      subTxt: "₹ Rupee",
    ),
    SettingsListData(
      titleTxt: 'United States Dollar',
      subTxt: "\$ USD",
    ),
    SettingsListData(
      titleTxt: 'Chinese Yuan',
      subTxt: "¥ Yuan",
    ),
    SettingsListData(
      titleTxt: 'Belgian Euro',
      subTxt: "€ Euro",
    ),
    SettingsListData(
      titleTxt: 'Brazilian Real',
      subTxt: "R\$ Real",
    ),
    SettingsListData(
      titleTxt: 'Canadian Dollar',
      subTxt: "\$ CAD",
    ),
    SettingsListData(
      titleTxt: 'Cuban Peso',
      subTxt: "₱ PESO",
    ),
    SettingsListData(
      titleTxt: 'French Euro',
      subTxt: "€ Euro",
    ),
    SettingsListData(
      titleTxt: 'Hong Kong Dollar',
      subTxt: "\$ HKD",
    ),
    SettingsListData(
      titleTxt: 'Italian Lira',
      subTxt: "€ Euro",
    ),
    SettingsListData(
      titleTxt: 'New Zealand Dollar',
      subTxt: "\$ NZ",
    ),
  ];

  static List<SettingsListData> helpSearchList = [
    SettingsListData(
      titleTxt: "paying_for_a_reservation",
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "How do I ",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "What methods ",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "When am I charged",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "How do I edit",
    ),
    SettingsListData(
      titleTxt: 'trust_and_safety',
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "I'm_a_guest_What",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "When am I charged",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "How do I edit",
    ),
    SettingsListData(
      titleTxt: "paying_for_a_reservation",
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "How do I ",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "What methods ",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "When am I charged",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "How do I edit",
    ),
    SettingsListData(
      titleTxt: 'trust_and_safety',
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "I'm_a_guest_What",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "When am I charged",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "How do I edit",
    ),
  ];

  static List<SettingsListData> subHelpList = [
    SettingsListData(titleTxt: "", subTxt: "You can cancel"),
    SettingsListData(
      titleTxt: "",
      subTxt: "GO to Trips and choose yotr trip",
    ),
    SettingsListData(titleTxt: "", subTxt: "You'll be taken to"),
    SettingsListData(titleTxt: "", subTxt: "If you cancel, your "),
    SettingsListData(
      titleTxt: "",
      subTxt: "Give feedback",
      isSelected: true,
    ),
    SettingsListData(
      titleTxt: "Related articles",
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: "",
      subTxt: "Can I change",
    ),
    SettingsListData(
      titleTxt: "",
      subTxt: "HoW do I cancel",
    ),
    SettingsListData(
      titleTxt: "",
      subTxt: "What is the",
    ),
  ];
}
