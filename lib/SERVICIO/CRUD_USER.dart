import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../POO/UsuarioJSON.dart';

class UsuariosProvider extends ChangeNotifier {
  final String _url = 'https://band-crud-default-rtdb.firebaseio.com/';

  Future<bool> crearUsuario(UsuarioModel usuario) async {
    final url = '$_url/usuarios.json';
    final resp =
        await http.post(Uri.parse(url), body: usuarioModelToJson(usuario));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    notifyListeners();
    return true;
  }

  Future<List<UsuarioModel>> cargarUsuarios() async {
    final url = '$_url/usuarios.json';

    final resp = await http.get(Uri.parse(url));

    if (resp.statusCode == 200) {
      if (resp.body.isEmpty) {
        return []; // Si la respuesta está vacía, devolvemos una lista vacía.
      }

      final dynamic decodedData = json.decode(resp.body);

      if (decodedData == null) {
        return []; // Si decodedData es nulo, devolvemos una lista vacía.
      }

      if (decodedData is Map<String, dynamic>) {
        final List<UsuarioModel> usuarios = [];

        decodedData.forEach((idbd, prod) {
          final prodTemp = UsuarioModel.fromJson(prod);
          prodTemp.id = idbd;
          usuarios.add(prodTemp);
        });
        notifyListeners();
        return usuarios;
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      // Manejo de errores en caso de que la solicitud no sea exitosa
      throw Exception('Failed to load data');
    }
  }

  Future<int> borrarUsuario(String id) async {
    final url = '$_url/usuarios/$id.json';

    final resp = await http.delete(Uri.parse(url));

    print(json.decode(resp.body));
    notifyListeners();
    return 1;
  }

  Future<bool> editarUsuario(UsuarioModel usuario) async {
    final url = '$_url/usuarios/${usuario.id}.json';

    final resp =
        await http.put(Uri.parse(url), body: usuarioModelToJson(usuario));

    final decodedData = json.decode(resp.body);

    print(decodedData);
    return true;
  }
}
