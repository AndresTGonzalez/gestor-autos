import 'package:app_moviles/screens/screens.dart';
import 'package:app_moviles/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('Espere...');
            } else if (snapshot.data == '') {
              Future.microtask(
                () => Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return LoginScreen();
                    },
                    transitionDuration: Duration(seconds: 0),
                  ),
                ),
              );
            } else {
              Future.microtask(
                () => Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return HomeScreen();
                    },
                    transitionDuration: Duration(seconds: 0),
                  ),
                ),
              );
            }
            return Container();
          },
          future: authService.readToken(),
        ),
      ),
    );
  }
}
