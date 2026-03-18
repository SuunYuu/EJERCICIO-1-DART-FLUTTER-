// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_instructor_diego/ui/views/login/Login.dart';
import 'package:proyecto_instructor_diego/widgets/Header.dart';
import 'package:proyecto_instructor_diego/widgets/Logo.dart';
import '../../../utils/Global.colors.dart';
import '../../../widgets/TextFieldCustom.dart';
import 'package:proyecto_instructor_diego/services/api_service.dart';

final TextEditingController signUpUserController = TextEditingController();
final TextEditingController signUpPasswordController = TextEditingController();
final TextEditingController signUpConfirmPasswordController =
    TextEditingController();

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 0),
        physics: const BouncingScrollPhysics(),
        children: [
          Stack(
            children: [HeaderLogin(), LogoHeader()],
          ),
          const SignUpTitle(),
          const SignUpTextFields(),
          const SignUpButton(),
        ],
      ),
    );
  }
}

class SignUpTitle extends StatelessWidget {
  const SignUpTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              Get.off(() => const LoginView());
            },
            child: const Text(
              'SIGN IN',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const Text(
            '/',
            style: TextStyle(
              fontSize: 25,
              color: Colors.grey,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'SIGN UP',
              style: TextStyle(
                fontSize: 25,
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

class SignUpTextFields extends StatelessWidget {
  const SignUpTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          // Campo: usuario (api_user en BD)
          TextFieldCustom(
            type: TextInputType.text,
            icon: Icons.person_outlined,
            label: 'Usuario',
            hint: 'Ingresa tu nombre de usuario',
            controller: signUpUserController,
          ),
          const SizedBox(height: 20),
          // Campo: contraseña (api_password en BD)
          TextFieldCustom(
            type: TextInputType.visiblePassword,
            icon: Icons.lock_outline,
            label: 'Contraseña',
            hint: 'Ingresa tu contraseña',
            pass: true,
            controller: signUpPasswordController,
          ),
          const SizedBox(height: 20),
          // Campo: confirmar contraseña (solo validación en cliente)
          TextFieldCustom(
            type: TextInputType.visiblePassword,
            icon: Icons.lock_outline,
            label: 'Confirmar contraseña',
            hint: 'Repite tu contraseña',
            pass: true,
            controller: signUpConfirmPasswordController,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: GlobalColors.secondaryColorH,
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: TextButton(
        onPressed: () async {
          final user = signUpUserController.text.trim();
          final password = signUpPasswordController.text.trim();
          final confirmPassword = signUpConfirmPasswordController.text.trim();

          // Validación: campos vacíos
          if (user.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
            Get.snackbar(
              "Error",
              "Todos los campos son obligatorios",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: GlobalColors.dangerColor,
              colorText: Colors.white,
            );
            return;
          }

          // Validación: contraseñas coinciden
          if (password != confirmPassword) {
            Get.snackbar(
              "Error",
              "Las contraseñas no coinciden",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: GlobalColors.dangerColor,
              colorText: Colors.white,
            );
            return;
          }

          // Llamada al backend: POST /api_v1/apiUser
          // Envía: { user, password, status: "Active", role: "user" }
          final result = await ApiService.register(user, password);

          if (result["success"] == true) {
            // Limpiar campos
            signUpUserController.clear();
            signUpPasswordController.clear();
            signUpConfirmPasswordController.clear();

            Get.snackbar(
              "¡Éxito!",
              "Usuario registrado correctamente. Inicia sesión.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: GlobalColors.successColor,
              colorText: Colors.white,
            );
            // Regresar al login
            Get.off(() => const LoginView());
          } else {
            Get.snackbar(
              "Error",
              result["message"] ?? "Error al registrar usuario",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: GlobalColors.dangerColor,
              colorText: Colors.white,
            );
          }
        },
        child: const Text(
          'SIGN UP',
          style: TextStyle(
            height: 3.1,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
