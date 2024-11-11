import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_kripto/app/routes/route_name.dart';
import 'package:tugas_akhir_kripto/app/routes/route_page.dart';

import 'app/utils/constants.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  ).then(
        (_) {
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KriptoKeren',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: Constants.fontNamePoppins,
      ),
      getPages: RoutePage.routes,
      initialRoute: RouteName.splash,
    );
  }
}
