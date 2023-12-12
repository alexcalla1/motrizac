import 'package:flutter/material.dart';

import '../FUNCTION/Search.dart';
import '../POO/AlumnoJSON.dart';
import '../SERVICIO/CRUD_ALUMNO.dart';

class ListaPageAlumno extends StatefulWidget {
  @override
  State<ListaPageAlumno> createState() => _ListaPageAlumnoState();
}

class _ListaPageAlumnoState extends State<ListaPageAlumno> {
  int? dropdownValue;
  final alumnosProvider = AlumnosProvider();
  List<AlumnoModel> alumnos = [];
  final List<String> secciones = ['', 'A', 'B', 'C', 'D'];
  final List<String> grados = [
    '',
    'Primero',
    'Segundo',
    'Tercero',
    'Cuarto',
    'Quinto'
  ];

  String selectedSeccion = '';
  String selectedGrado = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 70, 16),
        title: const Text('Lista de  Alumnos '),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Future.delayed(Duration.zero, () {
                showSearch(
                  context: context,
                  delegate: AlumnoSearchDelegate(
                    alumnos,
                    (updatedAlumnos) {
                      setState(() {
                        alumnos = updatedAlumnos;
                      });
                    },
                    (selectedSeccion, selectedGrado) {
                      setState(() {
                        this.selectedSeccion = selectedSeccion;
                        this.selectedGrado = selectedGrado;
                      });
                    },
                    selectedSeccion, // Pasa los valores de los filtros
                    selectedGrado,
                  ),
                );
              });
            },
          ),
        ],
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(child: _crearListado()),
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Container(
                padding: EdgeInsets.only(right: 50.0),
                child: (_crearMediaDeAltura(context)),
              ),
            ),
          ),
        ],
      )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _crearBoton(context),
          SizedBox(height: 10), // Espacio entre los botones
        ],
      ),
    );
  }

  /*Widget _crearListado() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildSeccionDropdown(
                context), // Llama a la función para el filtro de sección
            buildGradoDropdown(
                context), // Llama a la función para el filtro de grado
          ],
        ),
        SizedBox(height: 10),
        Expanded(
          child:return FutureBuilder(
            future: alumnosProvider.cargarAlumnos(),
            builder: (BuildContext context,
                AsyncSnapshot<List<AlumnoModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error al cargar los alumnossss"),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text("No hay alumnos disponibles"),
                );
              } else {
                alumnos = snapshot.data!; // Actualiza la lista de alumnos
                return ListView.builder(
                  itemCount: alumnos.length,
                  itemBuilder: (context, i) => _crearItem(context, alumnos[i]),
                );
              }
            },
          );
        ),
      ],
    );
  }*/

  Widget _crearListado() {
    return FutureBuilder(
      future: alumnosProvider.cargarAlumnos(),
      builder:
          (BuildContext context, AsyncSnapshot<List<AlumnoModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error al cargar los productos"),
          );
        } else {
          alumnos =
              snapshot.data ?? []; // Obtén la lista de alumnos del snapshot

          if (alumnos.isEmpty) {
            return Center(
              child: Text("No hay alumnos disponibles"),
            );
          } else {
            return ListView.builder(
              itemCount: alumnos.length,
              itemBuilder: (context, i) => _crearItem(context, alumnos[i]),
            );
          }
        }
      },
    );
  }

  _crearMediaDeAltura(BuildContext context) {
    setState(() {});
    return FutureBuilder(
      future: alumnosProvider.cargarAlumnos(),
      builder:
          (BuildContext context, AsyncSnapshot<List<AlumnoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data!;
          if (productos.isNotEmpty) {
            double sumaedad = 0;
            double sumapeso = 0;
            double sumaaltura = 0;
            double sumacintura = 0;
            double sumabmi = 0;
            double sumacadencia = 0;
            double sumapasos = 0;
            double sumavelocidad = 0;
            double sumazancada = 0;
            for (var i = 0; i < productos.length; i++) {
              sumaaltura = sumaaltura + productos[i].altura;
              sumaedad = sumaedad + productos[i].edad;
              sumapeso = sumapeso + productos[i].peso;
              sumacintura = sumacintura + productos[i].circuncintura;
              sumabmi = sumabmi + productos[i].bmi;
              sumacadencia = sumacadencia + productos[i].cadencia;
              sumapasos = sumapasos + productos[i].pasos;
              sumavelocidad = sumavelocidad + productos[i].velocidad;
              sumazancada = sumazancada + productos[i].zancada;
            }
            double mediaaltura = sumaaltura / productos.length;
            double mediaedad = sumaedad / productos.length;
            double mediapeso = sumapeso / productos.length;
            double mediacintura = sumacintura / productos.length;
            double mediabmi = sumabmi / productos.length;
            double mediacadencia = sumacadencia / productos.length;
            double mediapasos = sumapasos / productos.length;
            double mediavelocidad = sumavelocidad / productos.length;
            double mediazancada = sumazancada / productos.length;
            mediaaltura = double.parse(
                mediaaltura.toStringAsFixed(2)); // Limitar a dos decimales
            mediaedad = double.parse(mediaedad.toStringAsFixed(2));
            mediapeso = double.parse(mediapeso.toStringAsFixed(2));
            mediacintura = double.parse(mediacintura.toStringAsFixed(2));
            mediabmi = double.parse(mediabmi.toStringAsFixed(2));
            mediacadencia = double.parse(mediacadencia.toStringAsFixed(2));
            mediapasos = double.parse(mediapasos.toStringAsFixed(2));
            mediavelocidad = double.parse(mediavelocidad.toStringAsFixed(2));
            mediazancada = double.parse(mediazancada.toStringAsFixed(2));

            _creardropdown(context) {
              return DropdownButton(
                isExpanded: true,
                hint: Text('Altura media'),
                value: dropdownValue,
                onChanged: (newvalue) {
                  setState(() {
                    dropdownValue = newvalue as int?;
                  });
                },
                items: [
                  DropdownMenuItem(
                    child: Text('Altura media'),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text('Edad media'),
                    value: 2,
                  ),
                  DropdownMenuItem(
                    child: Text('Peso medio'),
                    value: 3,
                  ),
                  DropdownMenuItem(
                    child: Text('cintura media'),
                    value: 4,
                  ),
                  DropdownMenuItem(
                    child: Text('BMI medio'),
                    value: 5,
                  ),
                  DropdownMenuItem(
                    child: Text('Cadencia media'),
                    value: 6,
                  ),
                  DropdownMenuItem(
                    child: Text('Pasos medios'),
                    value: 7,
                  ),
                  DropdownMenuItem(
                    child: Text('Velocidad media'),
                    value: 8,
                  ),
                  DropdownMenuItem(
                    child: Text('Zancada media'),
                    value: 9,
                  ),
                ],
              );
            }

            _crearresultado(context) {
              if (dropdownValue == 1) {
                return Text('Media de Altura: $mediaaltura cm');
              } else if (dropdownValue == 2) {
                return Text('Media de Edad: $mediaedad años');
              } else if (dropdownValue == 3) {
                return Text('Media de edad: $mediapeso kg');
              } else if (dropdownValue == 4) {
                return Text('Medida de cintura: $mediacintura cm');
              } else if (dropdownValue == 5) {
                return Text('BMI medio: $mediabmi');
              } else if (dropdownValue == 6) {
                return Text('Cadencia media: $mediacadencia');
              } else if (dropdownValue == 7) {
                return Text('Media de pasos: $mediapasos');
              } else if (dropdownValue == 8) {
                return Text('Velocidad media: $mediavelocidad');
              } else if (dropdownValue == 9) {
                return Text('Zancada media: $mediazancada');
              } else {
                return Text('Altura media: $mediaaltura cm');
              }
            }

            return Row(
              children: [
                Expanded(child: Center(child: _creardropdown(context))),
                Expanded(child: Center(child: _crearresultado(context))),
              ],
            );
          } else {
            return Center(
              child: Text("No hay productos disponibles"),
            );
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error al cargar los productos"),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, AlumnoModel alumno) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) {
        alumnosProvider.borrarAlumno(alumno.id!);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
            '${alumno.nombre} ${alumno.apellido}',
            style: TextStyle(
                fontSize: 18, // Tamaño de fuente personalizado
                fontWeight: FontWeight.bold, // Texto en negrita
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
          subtitle: Text(
            '${alumno.edad} Edad - ${alumno.pasos} Pasos',
            style: TextStyle(
                fontSize: 14, // Tamaño de fuente personalizado,
                color: Color.fromARGB(255, 247, 246, 245)),
          ),
          onTap: () =>
              Navigator.pushNamed(context, 'alumno', arguments: alumno),
        ),
      ),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
        heroTag: "btn1",
        backgroundColor: Color.fromARGB(255, 2, 70, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add),
            Text('Add'),
          ],
        ),
        onPressed: () => Navigator.pushNamed(context, 'alumno'));
  }

  Widget buildSeccionDropdown(BuildContext context) {
    return DropdownButton<String>(
      value: selectedSeccion,
      items: secciones.map((seccion) {
        return DropdownMenuItem<String>(
          value: seccion,
          child: Text(seccion),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedSeccion = value!;
        });
      },
      hint: Text('Filtrar por Sección'),
    );
  }

  Widget buildGradoDropdown(BuildContext context) {
    return DropdownButton<String>(
      value: selectedGrado,
      items: grados.map((grado) {
        return DropdownMenuItem<String>(
          value: grado,
          child: Text(grado),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedGrado = value!;
        });
      },
      hint: Text('Filtrar por Grado'),
    );
  }
}
