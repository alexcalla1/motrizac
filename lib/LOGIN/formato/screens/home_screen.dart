import 'package:flutter/material.dart';
import 'package:motrizac/LOGIN/Auth.dart';

class HomeScreen extends StatelessWidget {
  AuthBase authBase = AuthBase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('Sign out'),
          onPressed: () async {
            await authBase.logout();
            Navigator.of(context).pushReplacementNamed('login');
          },
        ),
      ),
    );
  }
}
