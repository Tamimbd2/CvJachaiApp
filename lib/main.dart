import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/data/services/api_service.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => ApiService().init());
  
  runApp(
    GetMaterialApp(
      title: "Application",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    ),
  );
}
