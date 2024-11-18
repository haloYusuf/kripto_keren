import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/login_controller.dart';
import 'package:tugas_akhir_kripto/app/utils/constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Widget _gapVertical({required double gap}){
    return SizedBox(height: gap,);
  }

  Widget _gapHorizontal({required double gap}){
    return SizedBox(width: gap,);
  }

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find();
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
                    Constants.appName,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              _gapVertical(gap: 50),
              const Text(
                'Masuk',
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
              _gapVertical(gap: 5),
              Row(
                children: [
                  Text(
                    'Tidak punya akun?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Constants.colorBlack,
                    ),
                  ),
                  _gapHorizontal(gap: 5),
                  TextButton(
                    onPressed: (){
                      controller.toRegister();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(3),
                    ),
                    child: Text(
                      'Daftar',
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
                  controller.logIn();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.colorGreen,
                ),
                child: Text(
                  'Login',
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
