import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/data/services/auth_service.dart';

import '../../routes/route_name.dart';

class LoginController extends GetxController{
  late AuthService service;

  var visibilityPassword = true.obs;

  late TextEditingController usernameController;
  late TextEditingController passwordController;

  LoginController(){
    service = AuthService();

    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  void logIn(){
    final uName = usernameController.text;
    final pass = passwordController.text;

    if(uName.isEmpty){
      _showDialog(
        title: 'Gagal',
        message: 'Username wajib diisi.',
      );
    }else if(pass.isEmpty){
      _showDialog(
        title: 'Gagal',
        message: 'Password wajib diisi.',
      );
    }else{
      Get.defaultDialog(
        barrierDismissible: false,
        title: 'Loading',
        content: const CircularProgressIndicator(),
      );
      service.loginProcess(
        uName: uName,
        pass: _encryptPassword(pass: pass),
      ).then((value){
        Get.back();
        if(value){
          Get.offAllNamed(RouteName.main);
        }else{
          _showDialog(
            title: 'Gagal',
            message: 'Gagal melakukan login.',
          );
        }
      });
    }
  }

  void toRegister(){
    usernameController.clear();
    passwordController.clear();
    visibilityPassword.value = true;
    Get.toNamed(RouteName.register);
  }

  SnackbarController _showDialog({
    required String title,
    required String message,
  }){
    return Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 1),
    );
  }

  String _encryptPassword({required String pass}){
    var byte = utf8.encode(pass);
    var result = sha256.convert(byte);
    return result.toString();
  }
}