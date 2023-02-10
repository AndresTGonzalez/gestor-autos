import 'dart:io';

import 'package:flutter/material.dart';

import '../models/auto.dart';

class AutoImage extends StatelessWidget {
  final String? url;

  const AutoImage({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        width: double.infinity,
        height: 450,
        decoration: _ImageBoxDecoration(),
        child: Opacity(
          opacity: 0.9,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
            child: getImage(url),
          ),
        ),
      ),
    );
  }

  BoxDecoration _ImageBoxDecoration() => const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        ),
        color: Colors.black12,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      );

  Widget getImage(String? picture) {
    if (picture == '') {
      return const Image(
        image: AssetImage('images/no-image.png'),
        fit: BoxFit.cover,
      );
    } else if (picture!.startsWith('http')) {
      return FadeInImage(
        placeholder: const AssetImage('images/jar-loading.gif'),
        image: NetworkImage(url.toString()),
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(picture),
        fit: BoxFit.cover,
      );
    }
  }
}
