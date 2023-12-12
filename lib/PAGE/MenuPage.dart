import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 2, 70, 16),
        fontFamily: 'Arial',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Menu',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 2, 70, 16),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, 'listaalumno'),
                  child: Text(
                    'Ver/Añadir Alumnos',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 8, 177, 23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, 'imc'),
                  child: Text(
                    'Calculadora IMC',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 8, 177, 23),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, 'informacion'),
                  child: Text(
                    'Información',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 8, 177, 23),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacementNamed('login');
                    // Aquí puedes añadir cualquier otra lógica que desees después de cerrar sesión
                  },
                  child: Text(
                    'Cerrar Sesión',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 4, 65, 9),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//onPressed: () => Navigator.pushNamed(context, 'listaalumno')