import 'package:app_moviles/forms/registro_form.dart';
import 'package:flutter/material.dart';

import '../ui/ui.dart';

class RegistroScreen extends StatelessWidget {
  final Color negro = const Color(0xff231F20);
  final Color naranja = const Color(0xffFF4401);
  final Color blanco = const Color(0xfff2f2f2);

  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blanco,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              UiElements.logo(context: context),
              UiElements.titulo(titulo: 'Registrarse'),
              const SizedBox(
                height: 20,
              ),
              RegistroForm(negro: negro, naranja: naranja, blanco: blanco)
            ],
          ),
        ),
      ),
    );
  }
}
