import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

var apiURL = "https://127.0.0.1:8000";
var loginURL = "${apiURL}/login";
var music = "${apiURL}/club/music";
var feed = "${apiURL}/club/feed";

abstract class Paginate {
  final int count;
  String? next;
  final String? previous;

  Paginate(this.count, this.next, this.previous);
}

class User {
  final String username;
  final String email;
  final String? first_name;
  final String? last_name;
  final int type;
  String? image;
  String location;
  final List<Music> music;

  User(
      {required this.username,
      required this.email,
      required this.location,
      required this.music,
      required this.type,
      this.first_name,
      this.last_name,
      this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['user_data']['username'],
        email: json['user_data']['email'],
        location: json['user_data']['location'],
        type: json['user_data']['type'],
        first_name: json['user_data']['first_name'],
        last_name: json['user_data']['last_name'],
        image: json['user_data']['image'],
        music: resolve_music_from_list(json['user_data']['music']));
  }
}

class Attende {
  final String username;

  Attende({required this.username});

  factory Attende.fromJson(Map<String, dynamic> json) {
    return Attende(username: json['username']);
  }
}

class Music {
  final String slug;
  final String genre;

  const Music({
    required this.slug,
    required this.genre,
  });

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      slug: json['slug'],
      genre: json['genre'],
    );
  }
}

class Type {
  final String name;
  final String slug;

  const Type({
    required this.name,
    required this.slug,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      slug: json['slug'],
      name: json['name'],
    );
  }
}

class Event {
  final String name;
  final String description;
  final String slug;
  final String image;
  final bool is_active;
  final String start_time;
  final List<Attende> atendees;

  const Event({
    required this.name,
    required this.description,
    required this.slug,
    required this.image,
    required this.is_active,
    required this.start_time,
    required this.atendees,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      slug: json['slug'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      is_active: json['is_active'],
      start_time: json['start_time'],
      atendees: resolve_atendee_from_list(json['atendees']),
    );
  }
}

class PaginateEventFeed extends Paginate {
  final List<Event> results;

  PaginateEventFeed({
    required this.results,
    required int count,
    required String? next,
    required String? previous,
  }) : super(count, next, previous);

  factory PaginateEventFeed.fromJson(Map<String, dynamic> json) {
    return PaginateEventFeed(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: resolve_event_from_list(json['results']),
    );
  }
}

class Place {
  final String name;
  final String description;
  final String slug;
  final String image;
  final double latitude;
  final double longitude;
  final String street_name;
  final String location;
  final bool? is_admin;
  final Type type;
  final List<Event> events;
  final List<Music> music;

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'],
      description: json['description'],
      slug: json['slug'],
      image: json['image'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      street_name: json['street_name'],
      location: json['location'],
      is_admin: json['is_admin'],
      type: resolve_type(json['type']),
      events: resolve_event_from_list(json['events']),
      music: resolve_music_from_list(json['music']),
    );
  }

  Place(
      {required this.name,
      required this.description,
      required this.slug,
      required this.image,
      required this.latitude,
      required this.longitude,
      required this.street_name,
      required this.location,
      required this.is_admin,
      required this.type,
      required this.events,
      required this.music});
}

class PaginatePlaceFeed extends Paginate {
  final List<Place> results;

  PaginatePlaceFeed({
    required this.results,
    required int count,
    required String? next,
    required String? previous,
  }) : super(count, next, previous);

  factory PaginatePlaceFeed.fromJson(Map<String, dynamic> json) {
    return PaginatePlaceFeed(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: resolve_place_from_list(json['results']),
    );
  }
}

class CreateAccountDTO {
  final String email;
  final String password;
  final String username;
  final List<String> music_slug;
  final int type;

  CreateAccountDTO(
      {required this.email,
      required this.password,
      required this.username,
      required this.music_slug,
      required this.type});

  static Map<String, dynamic> toJson(CreateAccountDTO data) => {
        "email": data.email,
        "password": data.password,
        "username": data.username,
        "music_slug": data.music_slug,
        "type": data.type
      };
}

class LoginDTO {
  final String email;
  final String password;

  LoginDTO({required this.email, required this.password});

  static Map<String, dynamic> toJson(LoginDTO data) => {
        "email": data.email,
        "password": data.password,
      };
}

class UpdateLocationDTO {
  final String location;

  UpdateLocationDTO({required this.location});

  static Map<String, dynamic> toJson(UpdateLocationDTO data) => {
        "location": data.location,
      };
}

class UpdateUserPicDTO {
  final File image;

  UpdateUserPicDTO({required this.image});
}

List<Music> resolve_music_from_list(map) {
  Iterable i = map;
  return List<Music>.from(i.map((e) => Music.fromJson(e)));
}

List<Event> resolve_event_from_list(map) {
  Iterable i = map;
  return List<Event>.from(i.map((e) => Event.fromJson(e)));
}

List<Place> resolve_place_from_list(map) {
  Iterable i = map;
  return List<Place>.from(i.map((e) => Place.fromJson(e)));
}

List<Attende> resolve_atendee_from_list(map) {
  Iterable i = map;
  return List<Attende>.from(i.map((e) => Attende.fromJson(e)));
}

Type resolve_type(type) {
  return Type.fromJson(type);
}

Future<List<Music>> fetchMusic(String search) async {
  final response = await http
      .get((Uri.parse("https://5cw4rvtc-8000.euw.devtunnels.ms/club/music")));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var decoded = jsonDecode(response.body);
    Iterable i = (decoded);
    return List<Music>.from(i.map((e) => Music.fromJson(e)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<PaginatePlaceFeed> fetchFeed() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final response;
  if (prefs.getBool("loggedIn") == true) {
    response = await http.get(
        Uri.parse("https://5cw4rvtc-8000.euw.devtunnels.ms/club/feed"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${prefs.getString("token").toString()}"
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var decoded = jsonDecode(response.body);
      return PaginatePlaceFeed.fromJson(decoded);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  } else {
    response = await http.get(
        Uri.parse("https://5cw4rvtc-8000.euw.devtunnels.ms/club/feed"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("DElimiter");
      print(response.body);
      var decoded = jsonDecode(response.body);
      return PaginatePlaceFeed.fromJson(decoded);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

Future<List<Type>> fetchTypes() async {
  final response = await http
      .get((Uri.parse("https://5cw4rvtc-8000.euw.devtunnels.ms/club/types")));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var decoded = jsonDecode(response.body);
    Iterable i = (decoded);
    return List<Type>.from(i.map((e) => Music.fromJson(e)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<String> createAccount(CreateAccountDTO data) async {
  final response = await http.post(
    Uri.parse("https://5cw4rvtc-8000.euw.devtunnels.ms/api/register"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(CreateAccountDTO.toJson(data)),
  );

  if (response.statusCode == 200) {
    var decoded = jsonDecode(response.body);
    return decoded['message'];
  } else {
    return "Something went wrong";
  }
}

Future<String> login(LoginDTO data) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final response = await http.post(
    Uri.parse("https://5cw4rvtc-8000.euw.devtunnels.ms/api/login"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(LoginDTO.toJson(data)),
  );

  if (response.statusCode == 200) {
    var decoded = jsonDecode(response.body);
    await prefs.setString("token", decoded['token']);
    await prefs.setBool("loggedIn", true);
    return "Welcome. Succesfuly logged in";
  } else if (response.statusCode == 403) {
    var decoded = jsonDecode(response.body);
    return decoded['message'];
  } else if (response.statusCode == 404) {
    var decoded = jsonDecode(response.body);
    return decoded['message'];
  } else {
    return "Something is wrong";
  }
}

Future<Place> placeDetails(String slug) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final response;
  if (prefs.getBool("loggedIn") == true) {
    response = await http.get(
        Uri.parse(
            "https://5cw4rvtc-8000.euw.devtunnels.ms/club/locale/${slug}"),
        headers: {
          "Authorization": "Bearer ${prefs.getString("token").toString()}"
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var decoded = jsonDecode(response.body);
      return Place.fromJson(decoded);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load place');
    }
  } else {
    response = await http.get(Uri.parse(
        "https://5cw4rvtc-8000.euw.devtunnels.ms/club/locale/${slug}"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var decoded = jsonDecode(response.body);
      return Place.fromJson(decoded);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

Future<PaginateEventFeed> fetchEvents() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final response;
  if (prefs.getBool("loggedIn") == true) {
    response = await http.get(
        Uri.parse("https://5cw4rvtc-8000.euw.devtunnels.ms/club/events"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${prefs.getString("token").toString()}"
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var decoded = jsonDecode(response.body);
      return PaginateEventFeed.fromJson(decoded);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  } else {
    response = await http.get(
        Uri.parse("https://5cw4rvtc-8000.euw.devtunnels.ms/club/feed"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      var decoded = jsonDecode(response.body);
      return PaginateEventFeed.fromJson(decoded);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

Future<User> fetchMe() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final response;
  if (prefs.getBool("loggedIn") == true) {
    response = await http.get(
        Uri.parse("https://5cw4rvtc-8000.euw.devtunnels.ms/api/me"),
        headers: {
          "Authorization": "Bearer ${prefs.getString("token").toString()}"
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var decoded = jsonDecode(response.body);
      return User.fromJson(decoded);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load place');
    }
  } else {
    throw Exception("You are not logged in");
  }
}

Future<String> updateUser(UpdateLocationDTO data) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final response = await http.post(
      Uri.parse("https://5cw4rvtc-8000.euw.devtunnels.ms/api/update"),
      body: jsonEncode(UpdateLocationDTO.toJson(data)),
      headers: {
        "Authorization": "Bearer ${prefs.getString("token").toString()}",
        "Content-Type": "application/json"
      });
  print(response.body);
  if (response.statusCode == 200) {
    var decoded = jsonDecode(response.body);
    return decoded['message'];
  } else {
    throw Exception("Something went wrong");
  }
}

Future<String> updateUserPic(String file) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, String> headers = {
    "Authorization": "Bearer ${prefs.getString("token").toString()}"
  };
  final request = await http.MultipartRequest(
      'POST', Uri.parse("https://5cw4rvtc-8000.euw.devtunnels.ms/api/update"));
  request.headers.addAll(headers);
  request.files.add(await http.MultipartFile.fromPath('key', file));
  var send = await request.send();
  var response = await http.Response.fromStream(send);
  if (response.statusCode == 200) {
    var decoded = jsonDecode(response.body);
    return decoded['message'];
  } else {
    throw Exception("Something went wrong");
  }
}
