import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';
import '../../controllers/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController splashController = Get.find();

    return Scaffold(
      backgroundColor: Constants.colorWhite,
      body: Center(
        child: Obx(() =>
            AnimatedOpacity(
              opacity: splashController.opacity.value,
              duration: const Duration(milliseconds: 1000),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/image/logo.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    Constants.appName,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      color: Constants.colorGreen,
                    ),
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}
