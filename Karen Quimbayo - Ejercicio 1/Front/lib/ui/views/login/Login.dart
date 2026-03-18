// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_instructor_diego/ui/views/login/SignUp.dart';
import 'package:proyecto_instructor_diego/widgets/Header.dart';
import 'package:proyecto_instructor_diego/widgets/Logo.dart';
import 'package:proyecto_instructor_diego/widgets/TextFieldCustom.dart';
import '../../../utils/Global.colors.dart';
import 'package:proyecto_instructor_diego/services/api_service.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static String id = "login_view";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 0),
        physics: const BouncingScrollPhysics(),
        children: const [
          Stack(children: [HeaderLogin(), LogoHeader()]),
          Title(),
          SizedBox(height: 40),
          EmailAndPassword(),
          ForgotPassword(),
          SizedBox(height: 40),
          ButtonSignIn(),
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
          const Text(
            'SIGN IN',
            style: TextStyle(fontSize: 25, color: Colors.grey),
          ),
          TextButton(
            onPressed: () {
              Get.to(const SignUp());
            },
            child: const Text(
              'SIGN UP',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmailAndPassword extends StatelessWidget {
  const EmailAndPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          TextFieldCustom(
            type: TextInputType.emailAddress,
            icon: Icons.email_outlined,
            label: 'Email',
            hint: 'Enter email address',
            controller: emailController,
          ),
          const SizedBox(height: 20),
          TextFieldCustom(
            type: TextInputType.visiblePassword,
            icon: Icons.password_outlined,
            label: 'Password',
            hint: 'Enter password',
            pass: true,
            controller: passwordController,
          ),
        ],
      ),
    );
  }
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 255, top: 25),
      alignment: Alignment.centerRight,
      child: const Text('Forgot Password'),
    );
  }
}

class ButtonSignIn extends StatelessWidget {
  const ButtonSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: GlobalColors.secondaryColorH,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      child: TextButton(
        onPressed: () async {
          final email = emailController.text.trim();
          final password = passwordController.text.trim();

          if (email.isEmpty || password.isEmpty) {
            Get.snackbar(
              "Error",
              "Ingrese email y contraseña",
              snackPosition: SnackPosition.BOTTOM,
            );
            return;
          }

          try {
            final result = await ApiService.login(email, password);

            if (result["success"] == true) {
              emailController.clear();
              passwordController.clear();
              Get.offNamed('/home');
            } else {
              Get.snackbar(
                "Error",
                result["message"] ?? "Credenciales incorrectas",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: GlobalColors.dangerColor,
                colorText: Colors.white,
              );
            }
          } catch (e) {
            Get.snackbar(
              "Error",
              "No se pudo conectar al servidor",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: GlobalColors.dangerColor,
              colorText: Colors.white,
            );
          }
        },
        child: const Text(
          'SIGN IN',
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
