import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auto_service.dart';
import '../ui/ui_elements.dart';
import '../widgets/auto_card.dart';

class VendidosScreen extends StatelessWidget {
  const VendidosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final autoService = Provider.of<AutoService>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            UiElements.titulo(titulo: 'Autos Vendidos'),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: ListView.builder(
                  itemCount: autoService.autos.length,
                  itemBuilder: (context, index) => GestureDetector(
                    child: !autoService.autos[index].estado
                        ? AutoCard(
                            auto: autoService.autos[index],
                          )
                        : Container(),
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
