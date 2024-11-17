import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/views/subscreen/stegano_decrypted_subscreen.dart';
import 'package:tugas_akhir_kripto/app/modules/views/subscreen/stegano_encrypted_subscreen.dart';

class SteganoController extends GetxController{
  List<Widget> dataView = [
    const SteganoEncryptedSubScreen(),
    const SteganoDecryptedSubScreen(),
  ];
}