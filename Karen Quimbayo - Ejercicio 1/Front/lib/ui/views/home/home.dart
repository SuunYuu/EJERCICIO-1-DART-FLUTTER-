import 'package:flutter/material.dart';

class HomeExample extends StatelessWidget {
  const HomeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenido 👋',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Esta es la pantalla principal de tu aplicación.',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Perfil'),
                subtitle: const Text('Ver información del usuario'),
                onTap: () {
                  print("Ir al perfil");
                },
              ),
            ),

            const SizedBox(height: 10),

            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Configuración'),
                subtitle: const Text('Ajustes de la aplicación'),
                onTap: () {
                  print("Ir a configuración");
                },
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print("Cerrar sesión");
                },
                child: const Text("Cerrar sesión"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

