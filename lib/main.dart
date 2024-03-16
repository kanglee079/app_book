import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'firebase_options.dart';
import 'manage/controllers/theme_controller.dart';
import 'manage/services/auth_service.dart';
import 'manage/services/store_service.dart';
import 'manage/stores/user_store.dart';
import 'pages/my_app.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterDownloader.initialize(debug: true);

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

Future<void> requestStoragePermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
}
