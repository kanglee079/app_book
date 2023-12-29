import 'package:app_book/manage/controllers/theme_controller.dart';
import 'package:app_book/manage/services/auth_service.dart';
import 'package:app_book/manage/services/store_service.dart';
import 'package:app_book/manage/stores/user_store.dart';
import 'package:app_book/pages/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'firebase_options.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("4ef789ff-548a-4239-9d45-8324237cd02b");

  OneSignal.Notifications.requestPermission(true);
  await Firebase.initializeApp(
    // name: 'demoapp',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.lazyPut<ThemeController>(() => ThemeController());
  Get.lazyPut(() => AuthService());
  await Get.putAsync(() => StoreService().init());
  await Get.putAsync(() => UserStore().onInit());
  runApp(const MyApp());
}
