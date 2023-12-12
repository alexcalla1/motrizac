import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) =>
    UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
  String? id;
  String contrasena;
  String email;
  String nombre;

  UsuarioModel({
    this.id,
    this.contrasena = '',
    this.email = '',
    this.nombre = '',
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["id"],
        contrasena: json["contrasena"],
        email: json["email"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        //"id"        : id,
        "contrasena": contrasena,
        "email": email,
        "nombre": nombre,
      };
}
