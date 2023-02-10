import 'package:app_moviles/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../ui/ui.dart';

class UsuarioForm extends StatelessWidget {
  const UsuarioForm({
    super.key,
    required this.negro,
    required this.naranja,
    required this.blanco,
  });

  final Color negro;
  final Color naranja;
  final Color blanco;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistroFormProvider(),
      child: _Formulario(negro: negro, naranja: naranja, blanco: blanco),
    );
  }
}

class _Formulario extends StatelessWidget {
  const _Formulario({
    required this.negro,
    required this.naranja,
    required this.blanco,
  });

  final Color negro;
  final Color naranja;
  final Color blanco;

  @override
  Widget build(BuildContext context) {
    final registroForm = Provider.of<RegistroFormProvider>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: registroForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              validator: (value) {
                if (value != null && value.length >= 6) {
                  return null;
                } else {
                  return 'Contraseña mínima de 6 caracteres';
                }
              },
              onChanged: (value) {
                registroForm.password = value;
              },
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecorations.authInputDecoration(
                hintText: '********',
                labelText: 'Contraseña',
                color: negro,
                prefixIcon: Icons.password_rounded,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              autocorrect: false,
              validator: (value) {
                if (value == registroForm.password) {
                  return null;
                } else {
                  return 'Las contraseñas no coincinden';
                }
              },
              onChanged: (value) {
                registroForm.repeatPassword = value;
              },
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecorations.authInputDecoration(
                hintText: '********',
                labelText: 'Repita la contraseña',
                color: negro,
                prefixIcon: Icons.password_rounded,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            MaterialButton(
              onPressed: () async {
                final authService =
                    Provider.of<AuthService>(context, listen: false);
                final String? resp =
                    await authService.changePassword(registroForm.password);
                if (resp == null) {
                  // Navigator.pushReplacementNamed(context, 'home');
                  authService.logout();
                  Navigator.pushReplacementNamed(context, 'login');
                  NotificationsService.showSnackBar('Vuelva a iniciar sesión');
                  registroForm.isLoading = false;
                } else {
                  NotificationsService.showSnackBar(resp);

                  print(resp);
                  // registroForm.isLoading = false;
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: naranja,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Cambiar contraseña',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: blanco,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                final authService =
                    Provider.of<AuthService>(context, listen: false);
                authService.logout();
                Navigator.pushReplacementNamed(context, 'login');
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: negro,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Cerrar sesión',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: blanco,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
