import 'package:flutter/material.dart';

class UiElements {
  static Container logo({
    required BuildContext context,
  }) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      alignment: Alignment.center,
      child: Image.asset(
        'images/logo.png',
        width: 350,
      ),
    );
  }

  static Container titulo({required String titulo}) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.centerLeft,
      child: Text(
        titulo,
        style: const TextStyle(
          color: Color(0xff231F20),
          fontFamily: 'Poppins',
          fontSize: 30,
        ),
      ),
    );
  }
}
