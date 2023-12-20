import 'package:app_book/apps/route/route_name.dart';
import 'package:app_book/manage/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavMiddlewares extends GetMiddleware {
  @override
  int? priority = 0;

  @override
  RouteSettings? redirect(String? route) {
    const role = 'admin';
    if (role == 'user') {
      return RouteSettings(name: RouterName.navUser);
    }
    return null;
  }
}
