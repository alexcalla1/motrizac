import 'package:flutter/material.dart';
import 'package:motrizac/LOGIN/formato/screens/auth_screen.dart';
import 'package:motrizac/LOGIN/formato/widgets/original_button.dart';
import 'package:motrizac/LOGIN/auth.dart';

class AuthForm extends StatefulWidget {
  final AuthType authType;

  const AuthForm({Key? key, required this.authType}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '';
  AuthBase authBase = AuthBase();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: 'alexander@hotmail.com',
              decoration: InputDecoration(
                labelText: 'Ingresa tu Correo',
                hintText: 'ex: test@gmail.com',
              ),
              keyboardType: TextInputType.emailAddress, // Esto muestra el carácter '@' en el teclado
              onChanged: (value) {
                _email = value;
              },
             validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Necesitas ingresar un Mail valido';
              }
              return null;
            },

            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue: 'alexander',
              decoration: InputDecoration(
                labelText: 'Ingresa tu contraseña',
              ),
              obscureText: true,
              onChanged: (value) {
                _password = value;
              },
              validator: (value) {
                if (value == null || value.length <= 6) {
                  return 'Tu password tiene que tener almenos 6 caracteres';
                }
                return null;
              },

            ),
            SizedBox(height: 20),
              ElevatedButton(
                child: Text(widget.authType == AuthType.login ? 'Entrar' : 'Registrar', style: TextStyle(fontSize: 20)),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 9, 139, 48)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(double.infinity, 55))
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (widget.authType == AuthType.login) {
                      await authBase.loginWithEmailAndPassword(_email, _password);
                      Navigator.of(context).pushReplacementNamed('menu');
                    } else {
                      await authBase.registerWithEmailAndPassword(_email, _password);
                      Navigator.of(context).pushReplacementNamed('menu');
                    }
  //                  print(_email);
  //                  print(_password);
                  }
                },
              ),
            SizedBox(height: 6),
            TextButton(
              onPressed: () {
                if (widget.authType == AuthType.login) {
                  Navigator.of(context).pushReplacementNamed('register');
                  print(widget.authType);
                } else {
                  Navigator.of(context).pushReplacementNamed('login');
                }
              },
              child: Text(
                widget.authType == AuthType.login
                    ? '¿No tienes una cuenta?'
                    : '¿Ya tienes una cuenta creada?',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
