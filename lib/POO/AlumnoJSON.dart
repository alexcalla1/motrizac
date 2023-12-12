// To parse this JSON data, do
//
//     final alumnoModel = alumnoModelFromJson(jsonString);

import 'dart:convert';

AlumnoModel alumnoModelFromJson(String str) => AlumnoModel.fromJson(json.decode(str));

String alumnoModelToJson(AlumnoModel data) => json.encode(data.toJson());

class AlumnoModel {
    String? id;
    String seccion;
    String nombre;
    String apellido;
    int edad;
    double peso;
    double altura;
    double circuncintura;
    double bmi;
    int cadencia;
    int pasos;
    double velocidad;
    String grado;
    int zancada;

    AlumnoModel({
        this.id,
        this.nombre ='',
        this.grado ='',
        this.apellido='',
        this.edad=0,
        this.peso=0.0,
        this.altura=0.0,
        this.circuncintura=0.0,
        this.bmi=0.0,
        this.cadencia=0,
        this.pasos=0,
        this.seccion='',
        this.velocidad=0.0,
        this.zancada=0,
    });

    factory AlumnoModel.fromJson(Map<String, dynamic> json) => AlumnoModel(
        id: json["id"],
        nombre: json["nombre"],
        seccion: json['seccion'],
        apellido: json["Apellido"],
        edad: json["edad"],
        peso: json["Peso"]?.toDouble(),
        altura: json["Altura"]?.toDouble(),
        circuncintura: json["circuncintura"]?.toDouble(),
        bmi: json["BMI"]?.toDouble(),
        cadencia: json["cadencia"],
        grado: json['grado'],
        pasos: json["pasos"],
        velocidad: json["Velocidad"]?.toDouble(),
        zancada: json["Zancada"],
    );

    Map<String, dynamic> toJson() => {
        //"id": id,
        "seccion": seccion,
        "nombre": nombre,
        "Apellido": apellido,
        "edad": edad,
        "Peso": peso,
        "Altura": altura,
        "circuncintura": circuncintura,
        "BMI": bmi,
        "cadencia": cadencia,
        "pasos": pasos,
        "Velocidad": velocidad,
        "grado": grado,
        "Zancada": zancada,
    };
}