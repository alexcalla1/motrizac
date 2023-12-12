import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../POO/AlumnoJSON.dart';

class AlumnosProvider extends ChangeNotifier {
  final String _url = 'https://band-crud-default-rtdb.firebaseio.com';

  Future<bool> crearAlumno(AlumnoModel alumno) async {
    final url = '$_url/alumnos.json';
    final resp =
        await http.post(Uri.parse(url), body: alumnoModelToJson(alumno));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    notifyListeners();
    return true;
  }

  Future<List<AlumnoModel>> cargarAlumnos() async {
    final url = '$_url/alumnos.json';

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
        final List<AlumnoModel> alumnos = [];

        decodedData.forEach((idbd, prod) {
          final prodTemp = AlumnoModel.fromJson(prod);
          prodTemp.id = idbd;
          alumnos.add(prodTemp);
        });
        notifyListeners();
        return alumnos;
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      // Manejo de errores en caso de que la solicitud no sea exitosa
      throw Exception('Failed to load data');
    }
  }

  Future<int> borrarAlumno(String id) async {
    final url = '$_url/alumnos/$id.json';

    final resp = await http.delete(Uri.parse(url));

    print(json.decode(resp.body));
    notifyListeners();
    return 1;
  }

  Future<bool> editarAlumno(AlumnoModel alumno) async {
    final url = '$_url/alumnos/${alumno.id}.json';

    final resp =
        await http.put(Uri.parse(url), body: alumnoModelToJson(alumno));

    final decodedData = json.decode(resp.body);

    print(decodedData);
    return true;
  }

  void add(AlumnoModel result) {}
}
