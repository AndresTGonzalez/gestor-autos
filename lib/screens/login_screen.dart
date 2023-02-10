import 'package:flutter/material.dart';

import '../forms/forms.dart';
import '../ui/ui.dart';

class LoginScreen extends StatelessWidget {
  final Color negro = const Color(0xff231F20);
  final Color naranja = const Color(0xffFF4401);
  final Color blanco = const Color(0xfff2f2f2);

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blanco,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              UiElements.logo(context: context),
              UiElements.titulo(titulo: 'Iniciar Sesión'),
              const SizedBox(
                height: 20,
              ),
              LoginForm(negro: negro, naranja: naranja, blanco: blanco)
            ],
          ),
        ),
      ),
    );
  }
}
