import 'dart:convert';
import 'dart:io';

import 'package:app_moviles/models/models.dart';
import 'package:app_moviles/utils/cloudinary.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class AutoService extends ChangeNotifier {
  final String _urlBase =
      'https://app-moviles-1d98b-default-rtdb.firebaseio.com/autos.json';
  final List<Auto> autos = [];
  Auto? selectedAuto;

  bool _isLoading = true;
  bool _isSaving = false;

  bool get isLoading => _isLoading;
  bool get isSaving => isSaving;

  File? newPictureFile;

  AutoService() {
    this.loadAutos();
  }

  Future<List<Auto>> loadAutos() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(_urlBase);
    final resp = await http.get(url);
    final Map<String, dynamic> autosMap = jsonDecode(resp.body);
    autosMap.forEach((key, value) {
      final aux = Auto.fromMap(value);
      aux.id = key;
      autos.add(aux);
    });
    // print(autos[0].marca);
    _isLoading = false;
    notifyListeners();
    return autos;
  }

  Future saveOrCreateAuto(Auto auto) async {
    _isSaving = true;
    notifyListeners();

    if (auto.id == null) {
      //Crear
      await createAuto(auto);
    } else {
      //Editar
      await updateAuto(auto);
    }

    _isSaving = false;
    notifyListeners();
  }

  Future<String> updateAuto(Auto auto) async {
    const aux = 'https://app-moviles-1d98b-default-rtdb.firebaseio.com/autos';
    final url = Uri.parse('$aux/${auto.id}.json');
    final resp = await http.put(url, body: auto.toJson());
    final decodedData = resp.body;

    final index = this.autos.indexWhere((element) => element.id == auto.id);
    autos[index] = auto;

    return auto.id!;
  }

  Future<String> createAuto(Auto auto) async {
    final url = Uri.parse(_urlBase);
    final resp = await http.post(url, body: auto.toJson());
    final decodedData = jsonDecode(resp.body);

    autos.add(auto);

    auto.id = decodedData['name'];

    return auto.id!;
  }

  void updateSelectedAutoImage(String path) {
    selectedAuto?.imagen = path;
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;
    _isSaving = true;
    notifyListeners();
    final url = Uri.parse(Cloudinary.url);
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print(resp.body);
      return null;
    } else {
      newPictureFile = null;
      final decodedData = jsonDecode(resp.body);
      return decodedData['secure_url'];
    }
  }
}
