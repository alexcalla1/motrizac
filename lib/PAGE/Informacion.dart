import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

class InformacionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('INFORMACIÓN'),
        backgroundColor: Color.fromARGB(255, 2, 70, 16),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Aplicacion diseñada por tesistas investigadores de la Universidad Católica Santa Maria',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'En este aplicación puedes encontrar información con respecto a tu índice de masa corporal, es importante saber pues es un indicador de salud',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Ingresar datos de alumnos, ver percentiles, Calcular mediante IA y ver condición fisica del alumno',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Requerimientos mínimos:',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 10), // Espacio adicional
                    Text('-Android 5.0 o superior',style: TextStyle(fontSize: 14),),
                    Text('-Conexión a internet',style: TextStyle(fontSize: 14),),
                    Text('-4 pulgadas de pantalla',style: TextStyle(fontSize: 14),),
                    // Puedes seguir agregando más widgets según tus necesidades
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              color: Color.fromARGB(255, 2, 70, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Todos los derechos reservados',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Versión 1.4.3',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
