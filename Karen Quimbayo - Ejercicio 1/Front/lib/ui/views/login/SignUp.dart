// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:proyecto_instructor_diego/ui/views/login/Login.dart';
import 'package:proyecto_instructor_diego/widgets/Header.dart';
import 'package:proyecto_instructor_diego/widgets/Logo.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../utils/Global.colors.dart';
import '../../../widgets/TextFieldCustom.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Controladores para los campos de texto
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  // Variable para mostrar el círculo de carga
  bool cargando = false;

  // Mensaje para mostrar errores
  String mensajeError = '';

  // Función para registrar usuario
  Future<void> registrarUsuario() async {
    // Validar campos vacíos
    if (userController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      setState(() {
        mensajeError = 'Por favor llena todos los campos';
      });
      return;
    }

    setState(() {
      cargando = true;
      mensajeError = '';
    });

    try {
      // Datos que pide tu API
      Map<String, dynamic> datos = {
        "user": emailController.text, // Tu API usa el email en "user"
        "password": passwordController.text,
        "status": "Active", // Por defecto activo
        "role": "read-only" // Por defecto read-only
      };

      // Llamada a la API
      var respuesta = await http.post(
        Uri.parse('http://localhost:3000/api_v1/apiUser'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(datos),
      );

      if (respuesta.statusCode == 200 || respuesta.statusCode == 201) {
        // Registro exitoso
        Get.snackbar(
          '¡Bienvenido!',
          'Registro completado',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        
        // Ir al login después de 1 segundo
        Future.delayed(const Duration(seconds: 1), () {
          Get.to(const LoginView());
        });
      } else {
        // Error del servidor
        setState(() {
          mensajeError = 'Error al registrar. Intenta de nuevo.';
        });
      }
    } catch (e) {
      setState(() {
        mensajeError = 'Error de conexión. ¿El servidor está corriendo?';
      });
    } finally {
      setState(() {
        cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 0),
        physics: const BouncingScrollPhysics(),
        children: [
          const Stack(
            children: [
              HeaderLogin(),
              LogoHeader(),
            ],
          ),
          const Title(),
          
          // Mensaje de error (si hay)
          if (mensajeError.isNotEmpty)
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                mensajeError,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          
          // Campos de texto
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                TextFieldCustom(
                  type: TextInputType.text,
                  icon: Icons.person_outlined,
                  label: 'Usuario',
                  hint: 'Escribe tu usuario',
                  controller: userController,
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  type: TextInputType.emailAddress,
                  icon: Icons.email_outlined,
                  label: 'Email',
                  hint: 'Escribe tu email',
                  controller: emailController,
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  type: TextInputType.phone,
                  icon: Icons.phone_outlined,
                  label: 'Teléfono',
                  hint: 'Escribe tu teléfono',
                  controller: phoneController,
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  type: TextInputType.visiblePassword,
                  icon: Icons.password_outlined,
                  label: 'Contraseña',
                  hint: 'Escribe tu contraseña',
                  pass: true,
                  controller: passwordController,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Botón de registro
          Container(
            margin: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: cargando ? Colors.grey : GlobalColors.secondaryColorH,
              borderRadius: BorderRadius.circular(50),
            ),
            child: TextButton(
              onPressed: cargando ? null : registrarUsuario,
              child: Text(
                cargando ? 'REGISTRANDO...' : 'REGISTRARME',
                style: const TextStyle(
                  height: 3.1,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              Get.to(const LoginView());
            },
            child: const Text(
              'INICIAR SESIÓN',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          const Text(
            '|',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              'REGISTRARME',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: GlobalColors.darkColorH,
              ),
            ),
          ),
        ],
      ),
    );
  }
}