import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/register_controller.dart';

import '../../../utils/constants.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  Widget _gapVertical({required double gap}){
    return SizedBox(height: gap,);
  }

  Widget _gapHorizontal({required double gap}){
    return SizedBox(width: gap,);
  }

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.find();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              _gapVertical(gap: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/logo.png',
                    width: 100,
                    height: 100,
                  ),
                  _gapHorizontal(gap: 10),
                  const Text(
                    'KriptoKeren',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              _gapVertical(gap: 50),
              const Text(
                'Buat Akun',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              _gapVertical(gap: 20),
              TextField(
                controller: controller.usernameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                  fontSize: 14,
                ),
                decoration: const InputDecoration(
                  labelText: 'Username',
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15,),
                  border: OutlineInputBorder(),
                ),
              ),
              _gapVertical(gap: 20),
              Obx(() =>
                  TextField(
                    controller: controller.passwordController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    obscureText: controller.visibilityPassword.value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      suffixIcon: IconButton(
                        onPressed: (){
                          controller.visibilityPassword.value = !controller.visibilityPassword.value;
                        },
                        icon: Icon(
                          controller.visibilityPassword.value ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
              ),
              _gapVertical(gap: 20),
              Obx(() =>
                  TextField(
                    controller: controller.confirmPasswordController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    obscureText: controller.visibilityConfirmPassword.value,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      suffixIcon: IconButton(
                        onPressed: (){
                          controller.visibilityConfirmPassword.value = !controller.visibilityConfirmPassword.value;
                        },
                        icon: Icon(
                          controller.visibilityConfirmPassword.value ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
              ),
              _gapVertical(gap: 5),
              Row(
                children: [
                  Text(
                    'Sudah punya akun?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Constants.colorBlack,
                    ),
                  ),
                  _gapHorizontal(gap: 5),
                  TextButton(
                    onPressed: (){
                      controller.back();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(3),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 14,
                        color: Constants.colorGreen,
                      ),
                    ),
                  ),
                ],
              ),
              _gapVertical(gap: 20),
              ElevatedButton(
                onPressed: (){
                  controller.register();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.colorGreen,
                ),
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 16,
                    color: Constants.colorWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
