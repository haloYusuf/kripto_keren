import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/login_controller.dart';
import 'package:tugas_akhir_kripto/app/utils/constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find();
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            controller.logIn();
          },
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 24,
              color: Constants.colorBlack,
            ),
          ),
        ),
      ),
    );
  }
}
