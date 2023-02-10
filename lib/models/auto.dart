import 'dart:convert';
import 'dart:ffi';

class Auto {
  Auto(
      {required this.estado,
      required this.anio,
      required this.marca,
      required this.modelo,
      required this.pago,
      required this.imagen,
      this.precio,
      required this.cilindraje,
      this.id});

  bool estado;
  int anio;
  String marca;
  String modelo;
  String pago;
  String? precio;
  String imagen;
  int cilindraje;
  String? id;

  factory Auto.fromJson(String str) => Auto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Auto.fromMap(Map<String, dynamic> json) => Auto(
      estado: json["estado"],
      anio: json["anio"],
      marca: json["marca"],
      modelo: json["modelo"].toString(),
      pago: json["pago"],
      imagen: json["imagen"],
      precio: json["precio"].toString(),
      cilindraje: json["cilindraje"],
      id: json["id"]);

  Map<String, dynamic> toMap() => {
        "estado": estado,
        "anio": anio,
        "marca": marca,
        "modelo": modelo,
        "pago": pago,
        "imagen": imagen,
        "precio": precio,
        "cilindraje": cilindraje,
        "id": id,
      };

  Auto copy() => Auto(
      estado: estado,
      anio: anio,
      marca: marca,
      modelo: modelo,
      pago: pago,
      precio: precio,
      imagen: imagen,
      cilindraje: cilindraje,
      id: id);
}
