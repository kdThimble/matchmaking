// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utilities/appUrls.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;
  String _token = "";

  var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};

  Status get loggedInStatus => _loggedInStatus;
  set loggedInStatus(Status value) {
    _loggedInStatus = value;
    notifyListeners();
  }

  String get token => _token;

  set setToken(String value) {
    _token = value;
    notifyListeners();
  }

  Status get registeredInStatus => _registeredInStatus;

  set registeredInStatus(Status value) {
    _registeredInStatus = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;
    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    print("password, $password , email $email");
    var url = Uri.parse(AppUrls.login);

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    print("Response ${response.body} ${response.statusCode}");

    if (response.statusCode >= 200 && response.statusCode < 300) {
      _loggedInStatus = Status.LoggedIn;
      final jsonResponse = jsonDecode(response.body);
      _token = jsonResponse['token'];
      print("token $token");
      notifyListeners();

      result = {'status': true, 'message': 'Login Successful'};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {'status': false, 'message': "Login Failed"};
    }

    return result;
  }

  Future<Map<String, dynamic>> signUp(
      String name, String email, String password) async {
    var result;
    _registeredInStatus = Status.Registering;
    notifyListeners();

    print("password, $password , email $email");
    var url = Uri.parse(AppUrls.register);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'fullName': name,
        'email': email,
        'password': password,
      }),
    );
    print("Response ${response.body} ${response.statusCode}");

    if (response.statusCode >= 200 && response.statusCode < 300) {
      _registeredInStatus = Status.Registered;
      final jsonResponse = jsonDecode(response.body);
      _token = jsonResponse['token'];
      print("token $token");
      notifyListeners();

      result = {'status': true, 'message': 'Registered Successfully'};
    } else {
      _registeredInStatus = Status.NotRegistered;
      notifyListeners();
      result = {'status': false, 'message': "Registration Failed"};
    }

    return result;
  }

  Future<Map<String, dynamic>> registerAgency(
      String name, String description) async {
    var result;
    var url = Uri.parse(AppUrls.registerAgency);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'description': description,
      }),
    );
    print("response ${response.body}");
    if (response.statusCode >= 200 && response.statusCode < 300) {
      _registeredInStatus = Status.Registered;
      final jsonResponse = jsonDecode(response.body);

      result = {'status': true, 'message': 'Registered Successfully'};
    } else {
      _registeredInStatus = Status.NotRegistered;
      notifyListeners();
      result = {'status': false, 'message': "Registration Failed"};
    }

    return result;
  }

  Future<Map<String, dynamic>> sendServiceRequest(
      String categoryId,
      String brief,
      String title,
      String city,
      String state,
      String zipCode,
      DateTime startDate,
      DateTime endDate,
      double minBudget,
      double maxBudget,
      bool manPowerNeeded) async {
    print("in service request");
    var result;

    var url = Uri.parse(AppUrls.sendServiceRequest);

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token',
      },
      body: jsonEncode(<String, dynamic>{
        'categoryId': categoryId,
        'brief': brief,
        'title': title,
        "address": {
          'city': city,
          'state': state,
          'zipCode': zipCode,
          "country": "",
          "lat": "",
          "lng": ""
        },
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'lowestBudget': minBudget,
        'highestBudget': maxBudget,
        'manPowerNeeded': manPowerNeeded,
      }),
    );
    print("Response ${response.body} ${response.statusCode}");

    if (response.statusCode >= 200 && response.statusCode < 300) {
      _loggedInStatus = Status.LoggedIn;
      final jsonResponse = jsonDecode(response.body);

      result = {'status': true, 'message': 'Request Sent Successful'};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {'status': false, 'message': "Request Failed"};
    }

    return result;
  }
}
