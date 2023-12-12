//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:motrizac/POO/AlumnoJSON.dart';

final TextEditingController queryTextController = TextEditingController();

class AlumnoSearchDelegate extends SearchDelegate<AlumnoModel> {
  final List<AlumnoModel> allAlumnos;
  final Function(List<AlumnoModel>) updateAlumnosList;
  final Function(String, String) updateFilters;
  String selectedSeccion;
  String selectedGrado;

  AlumnoSearchDelegate(this.allAlumnos, this.updateAlumnosList,
      this.updateFilters, this.selectedSeccion, this.selectedGrado);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          selectedSeccion = '';
          selectedGrado = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, AlumnoModel());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = allAlumnos.where((alumno) {
      final nombreApellido = '${alumno.nombre} ${alumno.apellido}';
      final nombreApellidoLower = nombreApellido.toLowerCase();
      final seccionLower = alumno.seccion.toLowerCase();
      final gradoLower = alumno.grado.toLowerCase();

      return nombreApellidoLower.contains(query.toLowerCase()) &&
          (this.selectedSeccion.isEmpty ||
              seccionLower == selectedSeccion.toLowerCase()) &&
          (this.selectedGrado.isEmpty ||
              gradoLower == selectedGrado.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${results[index].nombre} ${results[index].apellido}'),
          subtitle: Text(results[index].seccion),
          onTap: () => {
            Navigator.pushNamed(context, 'alumno', arguments: results[index]),
            updateFilters(selectedSeccion, selectedGrado)
          },
          /*{
            close(context, results[index]);

            updateAlumnosList(results);
          },*/
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = allAlumnos.where((alumno) {
      final nombreApellido = '${alumno.nombre} ${alumno.apellido}';
      final nombreApellidoLower = nombreApellido.toLowerCase();
      final seccionLower = alumno.seccion.toLowerCase();
      final gradoLower = alumno.grado.toLowerCase();

      return nombreApellidoLower.contains(query.toLowerCase()) &&
          (this.selectedSeccion.isEmpty ||
              seccionLower == selectedSeccion.toLowerCase()) &&
          (this.selectedGrado.isEmpty ||
              gradoLower == selectedGrado.toLowerCase());
    }).toList();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      color: Color.fromARGB(255, 221, 217, 217),
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3, // Agrega sombra alrededor del elemento
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            color: Color.fromARGB(255, 221, 217, 217),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  // const
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 13, 100, 16),
                    Color.fromARGB(255, 217, 235, 54)
                  ],
                ),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(5),
                title: Text(
                  '${results[index].nombre} ${results[index].apellido}',
                  style: TextStyle(
                      fontSize: 18, // Tamaño de fuente personalizado
                      fontWeight: FontWeight.bold, // Texto en negrita
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                subtitle: Text(
                  '${results[index].edad} Edad - ${results[index].pasos} Pasos',
                  style: TextStyle(
                      fontSize: 14, // Tamaño de fuente personalizado,
                      color: Color.fromARGB(255, 247, 246, 245)),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'alumno',
                      arguments: results[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildSearchBar(BuildContext context) {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          close(context, AlumnoModel());
        },
      ),
      title: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: queryTextController,
              textInputAction: TextInputAction.search,
              onSubmitted: (query) {
                showResults(context);
              },
              decoration: InputDecoration(
                hintText: 'Buscar por nombre o apellido',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showResults(context);
            },
          ),
        ],
      ),
    );
  }
}
