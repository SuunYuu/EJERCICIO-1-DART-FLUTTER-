// lib/ui/views/login/Login.dart (versión simple y funcional)

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proyecto_instructor_diego/ui/views/home/home.dart';
import 'package:proyecto_instructor_diego/ui/views/login/SignUp.dart';
import 'package:proyecto_instructor_diego/widgets/Header.dart';
import 'package:proyecto_instructor_diego/widgets/Logo.dart';
import 'package:proyecto_instructor_diego/widgets/TextFieldCustom.dart';
import '../../../utils/Global.colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = "login_view";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Controladores para los campos de texto
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  // Variable para mostrar carga
  bool cargando = false;
  
  // Variable para mensajes de error
  String mensajeError = '';

  // Función para iniciar sesión
  Future<void> iniciarSesion() async {
    // Validar que los campos no estén vacíos
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        mensajeError = 'Por favor ingresa email y contraseña';
      });
      return;
    }

    setState(() {
      cargando = true;
      mensajeError = '';
    });

    try {
     
      final url = Uri.parse('http://127.0.0.1:3000/api_v1/apiUserLogin');
      
      // Datos exactamente como los pide tu API
      Map<String, dynamic> datos = {
        "api_user": emailController.text.trim(),      
        "api_password": passwordController.text,      
      };

      print('Enviando: $datos'); // Para verificar en consola

      final respuesta = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(datos),
      );

      print('Código: ${respuesta.statusCode}');
      print('Respuesta: ${respuesta.body}');

      // Si la respuesta es exitosa (código 200)
      if (respuesta.statusCode == 200) {
        // Puedes verificar el cuerpo de la respuesta si tu API devuelve algo
        var respuestaJson = json.decode(respuesta.body);
        
        // Mostrar mensaje de éxito
        Get.snackbar(
          '¡Bienvenido!',
          'Has iniciado sesión correctamente',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        
        // Ir al home después de 1 segundo
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAll(const HomeExample());
        });
      } else {
        // Si el servidor devuelve error
        setState(() {
          mensajeError = 'Email o contraseña incorrectos';
        });
      }
    } catch (e) {
      // Error de conexión
      print('Error: $e');
      setState(() {
        mensajeError = 'Error de conexión. ¿El servidor está corriendo?';
      });
    } finally {
      // Quitar el indicador de carga
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
          // Header y Logo (tuyos)
          const Stack(
            children: [
              HeaderLogin(),
              LogoHeader(),
            ],
          ),
          
          // Título con navegación a registro
          const TitleSection(),
          
          // Mostrar mensaje de error si existe
          if (mensajeError.isNotEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red),
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
                  type: TextInputType.emailAddress,
                  icon: Icons.email_outlined,
                  label: 'Email',
                  hint: 'Ingresa tu email',
                  controller: emailController,
                ),
                const SizedBox(height: 30),
                TextFieldCustom(
                  type: TextInputType.visiblePassword,
                  icon: Icons.lock_outline,
                  label: 'Contraseña',
                  hint: 'Ingresa tu contraseña',
                  pass: true,
                  controller: passwordController,
                ),
              ],
            ),
          ),
          
          // Enlace "Olvidé mi contraseña"
          Container(
            padding: const EdgeInsets.only(right: 20, top: 20),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Get.snackbar(
                  'Recuperar contraseña',
                  'Función en desarrollo',
                  backgroundColor: Colors.orange,
                  colorText: Colors.white,
                );
              },
              child: const Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Botón de inicio de sesión
          Container(
            margin: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: cargando ? Colors.grey : GlobalColors.secondaryColorH,
              borderRadius: BorderRadius.circular(50),
            ),
            child: TextButton(
              onPressed: cargando ? null : iniciarSesion,
              child: Text(
                cargando ? 'INICIANDO...' : 'INICIAR SESIÓN',
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

// Sección de título separada para mantener orden
class TitleSection extends StatelessWidget {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          const Text(
            'INICIAR SESIÓN',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(width: 20),
          TextButton(
            onPressed: () {
              Get.to(const SignUp());
            },
            child: const Text(
              'REGISTRARME',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
