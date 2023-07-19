import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shop/models/http_exception.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _userId;
  String? _token;
  DateTime? _expiryDate;
  Timer? _autotimer;

  bool get isAuth {
    return _token != null;
  }

  String? get gettoken {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token!;
    }
    return null;
  }

  String? get getUserId {
    return _userId;
  }

  Future<bool> tryAutoLogIn() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('userData')) {
      return false;
    }
    final extractedData =
        json.decode(pref.getString('userData')!) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedData['expiryDate'].toString());
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedData['token'].toString();
    _userId = extractedData['userId'].toString();
    _expiryDate = expiryDate;
    notifyListeners();
    _autologOut();
    return true;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    try {
      final url =
          "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyABLzErrKwq_Y_oZStXGoOxsb_WacQ0F_Y";
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));
      print(response.body);
      var responseBody = json.decode(response.body);
      if (responseBody["error"] != null) {
        throw httpException(responseBody["error"]["message"]);
      }
      // final user = FirebaseAuth.instance.currentUser;
      // final authToken = await user!.getIdToken();
      //_token = authToken;
      _token = responseBody["idToken"];
      _userId = responseBody["localId"];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseBody["expiresIn"])));
      _autologOut();
      notifyListeners();

      final pref = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String()
      });
      pref.setString('userData', userData);
    } catch (error) {
      print("error from authenticate= $error");
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  //for log in
  Future<void> logIn(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  Future<void> LogOut() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_autotimer != null) {
      _autotimer!.cancel();
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  void _autologOut() {
    if (_autotimer != null) {
      _autotimer!.cancel();
      _autotimer = null;
    }
    final _timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _autotimer = Timer(Duration(seconds: _timeToExpiry), LogOut);
  }
}
