import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/views/subscreen/file_decrypted_subscreen.dart';
import 'package:tugas_akhir_kripto/app/modules/views/subscreen/file_encrypted_subscreen.dart';

class FileController extends GetxController{
  List<Widget> dataView = [
    const FileEncryptedSubScreen(),
    const FileDecryptedSubScreen(),
  ];
}