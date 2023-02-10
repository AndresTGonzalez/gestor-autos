import 'package:app_moviles/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../services/auth_service.dart';
import '../ui/ui.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
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
      create: (context) => LoginFormProvider(),
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
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Correo electrónico incorrecto';
              },
              onChanged: (value) {
                loginForm.email = value;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'jhon.doe@gmail.com',
                labelText: 'Correo electrónico',
                color: negro,
                prefixIcon: Icons.email_rounded,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              autocorrect: false,
              validator: (value) {
                if (value != null && value.length >= 6) {
                  return null;
                } else {
                  return 'Contraseña mínima de 8 caracteres';
                }
              },
              onChanged: (value) {
                loginForm.password = value;
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
            MaterialButton(
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      final authService =
                          Provider.of<AuthService>(context, listen: false);
                      if (!loginForm.isValidForm()) return;
                      loginForm.isLoading = true;
                      FocusScope.of(context).unfocus();
                      final String? resp = await authService.login(
                          loginForm.email, loginForm.password);
                      if (resp == null) {
                        Navigator.pushReplacementNamed(context, 'home');
                        loginForm.isLoading = false;
                      } else {
                        loginForm.isLoading = false;
                        // print(resp);
                        NotificationsService.showSnackBar(resp);
                        // registroForm.isLoading = false;
                      }
                      // await Future.delayed(const Duration(seconds: 1));
                      // // ignore: use_build_context_synchronously
                      // Navigator.pushReplacementNamed(context, 'home');
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
                  'Ingresar',
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
                Navigator.pushReplacementNamed(context, 'registro');
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
                  'Registrarse',
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
