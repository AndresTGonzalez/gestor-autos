import 'package:app_moviles/providers/providers.dart';
import 'package:app_moviles/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final Color negro = const Color(0xff231F20);
  final Color naranja = const Color(0xffFF4401);
  final Color blanco = const Color(0xfff2f2f2);

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeNavigationProvider(),
      child: Scaffold(
        bottomNavigationBar: _Navigation(
          negro: negro,
          naranja: naranja,
          blanco: blanco,
        ),
        body: const _Paginas(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    required this.negro,
    required this.naranja,
    required this.blanco,
  });

  final Color negro;
  final Color naranja;
  final Color blanco;

  @override
  Widget build(BuildContext context) {
    final navigation = Provider.of<HomeNavigationProvider>(context);
    return BottomNavigationBar(
      currentIndex: navigation.paginaActual,
      unselectedItemColor: blanco,
      backgroundColor: negro,
      onTap: (value) => navigation.paginaActual = value,
      fixedColor: naranja,
      items: const [
        BottomNavigationBarItem(
          label: 'Autos',
          icon: Icon(Icons.directions_car_rounded),
        ),
        BottomNavigationBarItem(
          label: 'Vendidos',
          icon: Icon(Icons.sell_rounded),
        ),
        BottomNavigationBarItem(
          label: 'Usuario',
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigation = Provider.of<HomeNavigationProvider>(context);
    return PageView(
      controller: navigation.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        AutomovilesScreen(),
        VendidosScreen(),
        UsuarioScreen(),
      ],
    );
  }
}
