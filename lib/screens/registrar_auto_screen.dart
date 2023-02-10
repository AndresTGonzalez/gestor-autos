import 'package:app_moviles/providers/providers.dart';
import 'package:app_moviles/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../forms/forms.dart';
import '../services/services.dart';

class RegistrarAutoScreen extends StatelessWidget {
  final Color negro = const Color(0xff231F20);
  final Color naranja = const Color(0xffFF4401);
  final Color blanco = const Color(0xfff2f2f2);

  RegistrarAutoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final autoService = Provider.of<AutoService>(context);
    return ChangeNotifierProvider(
      create: (context) => AutoFormProvider(autoService.selectedAuto!),
      child: _AutoScreenBody(
          autoService: autoService,
          negro: negro,
          naranja: naranja,
          blanco: blanco),
    );
  }
}

class _AutoScreenBody extends StatelessWidget {
  const _AutoScreenBody({
    super.key,
    required this.autoService,
    required this.negro,
    required this.naranja,
    required this.blanco,
  });

  final AutoService autoService;
  final Color negro;
  final Color naranja;
  final Color blanco;

  @override
  Widget build(BuildContext context) {
    final autoForm = Provider.of<AutoFormProvider>(context);
    final auto = autoForm.auto;
    return Scaffold(
      body: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                AutoImage(
                  url: autoService.selectedAuto?.imagen,
                ),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final picker = ImagePicker();
                      final PickedFile? pickedFile = await picker.getImage(
                          source: ImageSource.camera, imageQuality: 100);
                      if (pickedFile == null) {
                        return;
                      }
                      // print('tenemos imagen${pickedFile.path}');
                      autoService.updateSelectedAutoImage(pickedFile.path);
                    },
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 80,
                  child: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      autoService.deleteAuto(auto);
                      Navigator.of(context).popAndPushNamed('home');
                    },
                  ),
                ),
              ],
            ),
            AutoForm(
              negro: negro,
              naranja: naranja,
              blanco: blanco,
              auto: auto,
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (autoForm.isValidForm()) return;
          final String? imageUrl = await autoService.uploadImage();
          if (imageUrl != null) autoForm.auto.imagen = imageUrl;
          await autoService.saveOrCreateAuto(autoForm.auto);
          Navigator.of(context).popAndPushNamed('home');
        },
        backgroundColor: naranja,
        child: Icon(
          Icons.save_as_rounded,
          color: blanco,
        ),
      ),
    );
  }
}
