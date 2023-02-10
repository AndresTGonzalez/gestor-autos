import 'package:flutter/material.dart';

import '../models/auto.dart';

class AutoCard extends StatelessWidget {
  final Color negro = const Color(0xff231F20);
  final Color naranja = const Color(0xffFF4401);
  final Color blanco = const Color(0xfff2f2f2);

  const AutoCard({
    super.key,
    required this.auto,
  });

  final Auto auto;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 5),
            blurRadius: 10,
          )
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          _Imagen(
            auto: auto,
          ),
          _Detalles(
            auto: auto,
          ),
          Positioned(
            top: 0,
            right: 0,
            child: _Precio(
              auto: auto,
            ),
          ),
        ],
      ),
    );
  }
}

class _Precio extends StatelessWidget {
  final Color negro = const Color(0xff231F20);
  final Color naranja = const Color(0xffFF4401);
  final Color blanco = const Color(0xfff2f2f2);
  final Auto auto;
  const _Precio({
    required this.auto,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 50,
      decoration: BoxDecoration(
        color: negro,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(25.0),
          bottomLeft: Radius.circular(25.0),
        ),
      ),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '\$' + auto.precio.toString(),
            style: TextStyle(
                color: blanco,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class _Detalles extends StatelessWidget {
  final Color negro = const Color(0xff231F20);
  final Color naranja = const Color(0xffFF4401);
  final Color blanco = const Color(0xfff2f2f2);
  final Auto auto;
  const _Detalles({
    required this.auto,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: naranja,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${auto.marca} ${auto.modelo}',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: blanco,
                fontSize: 17,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              auto.anio.toString(),
              style: TextStyle(
                fontFamily: 'Poppins',
                color: blanco,
                fontSize: 15,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _Imagen extends StatelessWidget {
  final Auto auto;

  const _Imagen({
    required this.auto,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: Container(
        width: double.infinity,
        height: 300,
        child: auto.imagen.length <= 1
            ? const Image(
                image: AssetImage('images/no-image.png'),
              )
            : FadeInImage(
                placeholder: const AssetImage('images/jar-loading.gif'),
                image: NetworkImage(auto.imagen),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
