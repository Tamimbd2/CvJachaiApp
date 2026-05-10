import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

import 'app/data/services/api_service.dart';
import 'app/data/services/google_auth_service.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Get.putAsync(() => ApiService().init());
  Get.put(GoogleAuthService());

  
  final box = GetStorage();
  final bool isLoggedIn = box.read('is_logged_in') ?? false;
  
  runApp(
    GetMaterialApp(
      title: "CV JACHAI",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? Routes.navbar : Routes.login,
      getPages: AppPages.routes,
    ),
  );
}
