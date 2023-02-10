import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final Color naranja = const Color(0xffFF4401);
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Autos'),
      // ),
      body: Center(
        child: CircularProgressIndicator(
          color: naranja,
        ),
      ),
    );
  }
}
