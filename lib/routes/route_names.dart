import 'package:flutter/material.dart';
import 'package:gout/api/api.dart';
import 'package:gout/modules/hotel_detailes/create_place.dart';
import 'package:gout/models/hotel_list_data.dart';
import 'package:gout/modules/bottom_tab/bottom_tab_screen.dart';
import 'package:gout/modules/hotel_booking/filter_screen/filters_screen.dart';
import 'package:gout/modules/hotel_booking/hotel_home_screen.dart';
import 'package:gout/modules/hotel_detailes/attendes_list_screen.dart';
import 'package:gout/modules/hotel_detailes/event_details.dart';
import 'package:gout/modules/hotel_detailes/hotel_detailes.dart';
import 'package:gout/modules/hotel_detailes/reviews_list_screen.dart';
import 'package:gout/modules/hotel_detailes/room_booking_screen.dart';
import 'package:gout/modules/hotel_detailes/search_screen.dart';
import 'package:gout/modules/login/change_password.dart';
import 'package:gout/modules/login/forgot_password.dart';
import 'package:gout/modules/login/login_screen.dart';
import 'package:gout/modules/login/sign_up_Screen.dart';
import 'package:gout/modules/profile/country_screen.dart';
import 'package:gout/modules/profile/currency_screen.dart';
import 'package:gout/modules/profile/edit_profile.dart';
import 'package:gout/modules/profile/hepl_center_screen.dart';
import 'package:gout/modules/profile/how_do_screen.dart';
import 'package:gout/modules/profile/invite_screen.dart';
import 'package:gout/modules/profile/settings_screen.dart';
import 'package:gout/routes/routes.dart';

class NavigationServices {
  NavigationServices(this.context);

  final BuildContext context;

  Future<dynamic> _pushMaterialPageRoute(Widget widget,
      {bool fullscreenDialog: false}) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => widget, fullscreenDialog: fullscreenDialog),
    );
  }

  void gotoSplashScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, RoutesName.Splash, (Route<dynamic> route) => false);
  }

  void gotoHomeScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, RoutesName.Home, (Route<dynamic> route) => false);
  }

  void gotoIntroductionScreen() {
    Navigator.pushNamedAndRemoveUntil(context, RoutesName.IntroductionScreen,
        (Route<dynamic> route) => false);
  }

  Future<dynamic> gotoLoginScreen() async {
    return await _pushMaterialPageRoute(LoginScreen());
  }

  Future<dynamic> gotoTabScreen() async {
    return await _pushMaterialPageRoute(BottomTabScreen());
  }

  Future<dynamic> gotoSignScreen() async {
    return await _pushMaterialPageRoute(SignUpScreen());
  }

  Future<dynamic> gotoForgotPassword() async {
    return await _pushMaterialPageRoute(ForgotPasswordScreen());
  }

  Future<dynamic> gotoSearchScreen() async {
    return await _pushMaterialPageRoute(SearchScreen());
  }

  Future<dynamic> gotoHotelHomeScreen() async {
    return await _pushMaterialPageRoute(HotelHomeScreen());
  }

  Future<dynamic> gotoFiltersScreen() async {
    return await _pushMaterialPageRoute(FiltersScreen());
  }

  Future<dynamic> gotoRoomBookingScreen(String hotelname) async {
    return await _pushMaterialPageRoute(
        RoomBookingScreen(hotelName: hotelname));
  }

  Future<dynamic> gotoHotelDetailes(Place placeData) async {
    return await _pushMaterialPageRoute(PlaceDetails(
      placeData: placeData,
    ));
  }

  Future<dynamic> goToEventDetailsScreen(
      Event eventData, Place placeData) async {
    return await _pushMaterialPageRoute(EventDetails(
      eventData: eventData,
      placeData: placeData,
    ));
  }

  Future<dynamic> goToAtendeesListScreen(Event eventData) async {
    return await _pushMaterialPageRoute(AttendesListScreen(
      eventData: eventData,
    ));
  }

  Future<dynamic> gotoReviewsListScreen(Place placeData) async {
    return await _pushMaterialPageRoute(EventListScreen(
      placeData: placeData,
    ));
  }

  Future<dynamic> gotoEditProfile(User me) async {
    return await _pushMaterialPageRoute(EditProfile(me: me));
  }

  Future<dynamic> gotoSettingsScreen(User me) async {
    return await _pushMaterialPageRoute(SettingsScreen(me: me));
  }

  Future<dynamic> gotoHeplCenterScreen() async {
    return await _pushMaterialPageRoute(HeplCenterScreen());
  }

  Future<dynamic> gotoChangepasswordScreen() async {
    return await _pushMaterialPageRoute(ChangepasswordScreen());
  }

  Future<dynamic> gotoInviteFriend() async {
    return await _pushMaterialPageRoute(InviteFriend());
  }

  Future<dynamic> gotoCurrencyScreen() async {
    return await _pushMaterialPageRoute(CurrencyScreen(),
        fullscreenDialog: true);
  }

  Future<dynamic> gotoCountryScreen() async {
    return await _pushMaterialPageRoute(CountryScreen(),
        fullscreenDialog: true);
  }

  Future<dynamic> gotoHowDoScreen() async {
    return await _pushMaterialPageRoute(HowDoScreen());
  }

  Future<dynamic> goToCreatePlaceScreen() async{
    return await _pushMaterialPageRoute(CreatePlace());
  }
}
