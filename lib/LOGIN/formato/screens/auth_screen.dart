import 'package:flutter/material.dart';
import 'package:motrizac/LOGIN/formato/widgets/auth_form.dart';

enum AuthType { login, register }

class AuthScreen extends StatelessWidget {
  final AuthType authType;

  const AuthScreen({Key? key, required this.authType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 25, 216, 25),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 65),
                      /*const Text(
                        'Hola!!',
                        style: TextStyle(
                            color: Color.fromARGB(255, 14, 46, 14),
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2),
                      ),*/
                      SizedBox(height: 20),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              //texto continue debajo de si mismo para no desbordar
                              constraints: BoxConstraints(maxWidth: 250),
                              child: const Text(
                                'MotrizAC',
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
                      //Hero(
                      //  tag: 'logoAnimation',
                      //  child: Image.asset(
                      //    'assets/images/logo.png',
                      //    height: 250,
                      //  ),
                      //),
                    ],
                  ),
                ),
              ],
            ),
            AuthForm(authType: authType),
          ],
        ),
      ),
    );
  }
}
