import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tugas_akhir_kripto/app/routes/route_name.dart';

import '../../data/services/user_service.dart';

class RegisterController extends GetxController{

  late UserService service;

  var visibilityPassword = true.obs;
  var visibilityConfirmPassword = true.obs;

  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  RegisterController(){
    service = UserService();

    usernameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void back(){
    Get.back();
  }

  void register(){
    final uName = usernameController.text;
    final pass = passwordController.text;
    final confirmPass = confirmPasswordController.text;
    if(uName.isEmpty){
      _showDialog(
        title: 'Gagal',
        message: 'Username wajib diisi.',
      );
    }else if(pass.isEmpty){
      _showDialog(
        title: 'Gagal',
        message: 'Password tidak boleh kosong.',
      );
    }else if(pass != confirmPass){
      _showDialog(
        title: 'Gagal',
        message: 'Password tidak sesuai.',
      );
    }else if(pass.length < 8){
      _showDialog(
        title: 'Gagal',
        message: 'Panjang password minimal 8 karakter.',
      );
    }else{
      //Loading
      Get.defaultDialog(
        barrierDismissible: false,
        title: 'Loading',
        content: const CircularProgressIndicator(),
      );
      service.isAnyUser(uName: uName).then((value){
        if(value){
          service.registerProcess(
            uName: uName,
            pass: _encryptPassword(pass: pass),
            token: _generateUserToken(uName: uName),
          ).then((value){
            Get.back();
            if(value){
              Get.offAllNamed(RouteName.main);
            }else{
              _showDialog(
                title: 'Gagal',
                message: 'Gagal membuat akun.',
              );
            }
          });
        }else{
          Get.back();
          _showDialog(
            title: 'Gagal',
            message: 'Username sudah terdaftar di sistem.',
          );
        }
      });
    }
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

  String _generateUserToken({required String uName}){
    var now = DateTime.now();
    var formatter = DateFormat('yyyyMMMdd');
    String formatted = formatter.format(now);
    formatted = formatted + uName;
    var byte = utf8.encode(formatted);
    var result = sha256.convert(byte);
    return result.toString();
  }

  String _encryptPassword({required String pass}){
    var byte = utf8.encode(pass);
    var result = sha256.convert(byte);
    return result.toString();
  }
}