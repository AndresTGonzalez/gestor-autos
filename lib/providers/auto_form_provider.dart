import 'package:flutter/material.dart';

import '../models/auto.dart';

class AutoFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String marca = '';
  String modelo = '';
  int anio = 0;
  double precio = 0;
  int cilindraje = 0;
  String formasPago = '';
  bool disponible = false;

  Auto auto;

  AutoFormProvider(this.auto);

  updateAvailable(bool value) {
    auto.estado = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
