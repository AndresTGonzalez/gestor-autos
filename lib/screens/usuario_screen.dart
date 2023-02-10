import 'package:app_moviles/forms/usuario_form.dart';
import 'package:flutter/material.dart';

import '../ui/ui_elements.dart';

class UsuarioScreen extends StatelessWidget {
  final Color negro = const Color(0xff231F20);
  final Color naranja = const Color(0xffFF4401);
  final Color blanco = const Color(0xfff2f2f2);
  const UsuarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blanco,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              UiElements.titulo(titulo: 'Gestión del usuario'),
              const SizedBox(
                height: 150,
              ),
              UsuarioForm(negro: negro, naranja: naranja, blanco: blanco)
            ],
          ),
        ),
      ),
    );
  }
}
