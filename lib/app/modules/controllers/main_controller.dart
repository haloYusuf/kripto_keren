import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/route_name.dart';
import '../../utils/constants.dart';

class MainController extends GetxController{
  var currentIndex = 0.obs;
  final box = GetStorage();

  void logOut(){
    box.write(Constants.dataIsLogin, false);
    Get.offAllNamed(RouteName.login);
  }

  void changePage(int index){
    currentIndex.value = index;
  }
}