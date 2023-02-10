import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/auto.dart';
import '../providers/providers.dart';
import '../ui/ui.dart';

class AutoForm extends StatelessWidget {
  const AutoForm({
    super.key,
    required this.negro,
    required this.naranja,
    required this.blanco,
    required this.auto,
  });

  final Auto auto;
  final Color negro;
  final Color naranja;
  final Color blanco;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AutoFormProvider(auto),
      child: _Formulario(
        negro: negro,
        naranja: naranja,
        blanco: blanco,
        auto: auto,
      ),
    );
  }
}

class _Formulario extends StatelessWidget {
  const _Formulario({
    required this.negro,
    required this.naranja,
    required this.blanco,
    required this.auto,
  });

  final Auto auto;
  final Color negro;
  final Color naranja;
  final Color blanco;

  @override
  Widget build(BuildContext context) {
    final autoForm = Provider.of<AutoFormProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: autoForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              autocorrect: true,
              validator: (value) {},
              onChanged: (value) {
                // autoForm.email = value;
                auto.marca = value;
              },
              keyboardType: TextInputType.text,
              initialValue: auto.marca,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Chevrolet',
                labelText: 'Marca',
                color: negro,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              autocorrect: true,
              validator: (value) {},
              onChanged: (value) {
                // loginForm.email = value;
                auto.modelo = value;
              },
              keyboardType: TextInputType.text,
              initialValue: auto.modelo,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Aveo Emotion',
                labelText: 'Modelo',
                color: negro,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              autocorrect: false,
              validator: (value) {},
              onChanged: (value) {
                // loginForm.email = value;
                // autoForm.anio = value as int;
                if (int.tryParse(value) == null) {
                  auto.anio = 0;
                } else {
                  auto.anio = int.parse(value);
                }
              },
              keyboardType: TextInputType.number,
              initialValue: auto.anio.toString(),
              decoration: InputDecorations.authInputDecoration(
                hintText: '2020',
                labelText: 'Año',
                color: negro,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
              autocorrect: true,
              validator: (value) {},
              onChanged: (value) {
                // loginForm.email = value;
                if (double.tryParse(value) == null) {
                  auto.precio = 0.toString();
                } else {
                  auto.precio = value;
                }
              },
              keyboardType: TextInputType.number,
              initialValue: auto.precio,
              decoration: InputDecorations.authInputDecoration(
                hintText: '17500',
                labelText: 'Precio',
                color: negro,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              autocorrect: false,
              validator: (value) {},
              onChanged: (value) {
                // loginForm.email = value;
                if (int.tryParse(value) == null) {
                  auto.cilindraje = 0;
                } else {
                  auto.cilindraje = int.parse(value);
                }
              },
              keyboardType: TextInputType.number,
              initialValue: auto.cilindraje.toString(),
              decoration: InputDecorations.authInputDecoration(
                hintText: '1600',
                labelText: 'Cilindraje',
                color: negro,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              autocorrect: true,
              validator: (value) {},
              onChanged: (value) {
                // loginForm.email = value;
                auto.pago = value;
              },
              keyboardType: TextInputType.text,
              initialValue: auto.pago,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Crédito directo, crédito',
                labelText: 'Formas de pago',
                color: negro,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SwitchListTile.adaptive(
              value: auto.estado,
              onChanged: (value) => autoForm.updateAvailable(value),
              title: const Text('Disponible'),
              activeColor: naranja,
            )
          ],
        ),
      ),
    );
  }
}
