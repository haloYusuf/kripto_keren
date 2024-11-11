import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/route_name.dart';
import '../../utils/constants.dart';

class LoginController extends GetxController{
  final box = GetStorage();

  void logIn(){
    box.write(Constants.dataIsLogin, true);
    Get.offAllNamed(RouteName.main);
  }
}