import 'package:app_moviles/models/auto.dart';
import 'package:app_moviles/screens/screens.dart';
import 'package:app_moviles/services/services.dart';
import 'package:app_moviles/ui/ui.dart';
import 'package:app_moviles/widgets/auto_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AutomovilesScreen extends StatelessWidget {
  final Color negro = const Color(0xff231F20);
  final Color naranja = const Color(0xffFF4401);
  final Color blanco = const Color(0xfff2f2f2);

  const AutomovilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final autoService = Provider.of<AutoService>(context);

    if (autoService.isLoading) return const LoadingScreen();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          autoService.selectedAuto = Auto(
              estado: true,
              anio: 0,
              marca: '',
              modelo: '',
              pago: '',
              imagen: '',
              cilindraje: 0);
          Navigator.pushNamed(context, 'auto');
        },
        backgroundColor: negro,
        child: Icon(
          Icons.add_rounded,
          color: blanco,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            UiElements.titulo(titulo: 'Autos Disponibles'),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: ListView.builder(
                  itemCount: autoService.autos.length,
                  itemBuilder: (context, index) => GestureDetector(
                    child: AutoCard(
                      auto: autoService.autos[index],
                    ),
                    onTap: () {
                      autoService.selectedAuto =
                          autoService.autos[index].copy();
                      Navigator.pushNamed(context, 'auto');
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
