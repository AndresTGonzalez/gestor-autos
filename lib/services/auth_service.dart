import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _urlBase = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyC-_GnKVm5PTC5nkI0NQ6W7xsjVoztbjdM';

  final storage = FlutterSecureStorage();

  // Si retornamos algo es un error
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    final url =
        Uri.https(_urlBase, '/v1/accounts:signUp', {'key': _firebaseToken});
    final resp = await http.post(url, body: jsonEncode(authData));
    final Map<String, dynamic> decodedRes = jsonDecode(resp.body);
    if (decodedRes.containsKey('idToken')) {
      await storage.write(key: 'token', value: decodedRes['idToken']);
      //TOKEN SECURE STROTAGE
      // return decodedRes['idToken'];
      return null;
    } else {
      return decodedRes['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    final url = Uri.https(
        _urlBase, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});
    final resp = await http.post(url, body: jsonEncode(authData));
    final Map<String, dynamic> decodedRes = jsonDecode(resp.body);
    if (decodedRes.containsKey('idToken')) {
      //TOKEN SECURE STROTAGE
      // return decodedRes['idToken'];
      await storage.write(key: 'token', value: decodedRes['idToken']);
      return null;
    } else {
      print(decodedRes);
      return decodedRes['error']['message'];
    }
  }

  Future logout() async {
    await storage.deleteAll();
    return null;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
