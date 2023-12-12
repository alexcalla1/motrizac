import 'package:flutter/material.dart';

import '../POO/UsuarioJSON.dart';
import '../SERVICIO/CRUD_USER.dart';

class ListaPageUser extends StatefulWidget {
  @override
  State<ListaPageUser> createState() => _ListaPageUserState();
}

class _ListaPageUserState extends State<ListaPageUser> {
  final usuariosProvider = UsuariosProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios ' 'Home' ''),
      ),
      body: _crearListado(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _crearBoton(context),
          SizedBox(height: 10), // Espacio entre los botones
        ],
      ),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: usuariosProvider.cargarUsuarios(),
      builder:
          (BuildContext context, AsyncSnapshot<List<UsuarioModel>> snapshot) {
        if (snapshot.hasData) {
          final usuarios = snapshot.data!;
          if (usuarios.isNotEmpty) {
            return ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, i) => _crearItem(context, usuarios[i]),
            );
          } else {
            return Center(
              child: Text("No hay usuarios disponibles"),
            );
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error al cargar los usuarios"),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, UsuarioModel usuario) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) {
        usuariosProvider.borrarUsuario(usuario.id!);
      },
      child: ListTile(
        title: Text('${usuario.nombre} - ${usuario.email}'),
        subtitle: Text(usuario.id ?? 'ID no disponible'),
        onTap: () =>
            Navigator.pushNamed(context, 'usuario', arguments: usuario),
      ),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
        heroTag: "btn1",
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'usuario'));
  }
}
