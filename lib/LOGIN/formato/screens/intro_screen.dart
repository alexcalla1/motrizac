import 'package:flutter/material.dart';
import 'package:motrizac/LOGIN/formato/widgets/original_button.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 226, 46),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(),
            Image.asset(
              'assets/images/ESCUDOUCSM.png',
              height: 80,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(maxWidth: 250),
                    child: const Text(
                      'Bienvenido a MotrizAC',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 103, 121, 103),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/images/logosinfondo.png',
                      height: 60,
                    ),
                  ),
                ],
              ),
            ),


            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: ElevatedButton(
                  child: Text('Iniciar sesión'),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 37, 94, 4), // Cambia el color de fondo a negro
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('login');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
