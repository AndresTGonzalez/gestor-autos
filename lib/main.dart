import 'package:app_moviles/screens/screens.dart';
import 'package:app_moviles/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AutoService(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthService(),
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      scaffoldMessengerKey: NotificationsService.messengerKey,
      debugShowCheckedModeBanner: false,
      routes: {
        'login': (context) => const LoginScreen(),
        'home': (context) => const HomeScreen(),
        'registro': (context) => const RegistroScreen(),
        'auto': (context) => RegistrarAutoScreen(),
        'checking': (context) => const CheckOutScreen(),
      },
      initialRoute: 'checking',
    );
  }
}
