import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/route_name.dart';
import '../../utils/constants.dart';

class MainController extends GetxController{
  var currentIndex = 0.obs;
  final _box = GetStorage();
  var userName = 'Anonymous';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userName = _box.read(Constants.dataUser) ?? 'Anonymous';
  }

  void logOut(){
    _box.write(Constants.dataIsLogin, false);
    _box.remove(Constants.dataUserToken);
    Get.offAllNamed(RouteName.login);
  }

  void changePage(int index){
    currentIndex.value = index;
  }

  void toNewChat(){
    Get.toNamed(RouteName.newChat);
  }
}