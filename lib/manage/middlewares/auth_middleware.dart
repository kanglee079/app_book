import 'package:app_book/apps/route/route_name.dart';
import 'package:app_book/manage/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddlewares extends GetMiddleware {
  @override
  int? priority = 0;

  @override
  RouteSettings? redirect(String? route) {
    bool isLogin = UserStore.to.isLogin;
    String role = UserStore.to.userRole;

    if (route == RouterName.register) {
      return null;
    }

    if (!isLogin && route != RouterName.login) {
      return RouteSettings(name: RouterName.login);
    }

    if (isLogin) {
      if (role == 'isUser' && route != RouterName.navUser) {
        return RouteSettings(name: RouterName.navUser);
      } else if (role == 'isAdmin' && route != RouterName.nav) {
        return RouteSettings(name: RouterName.nav);
      }
    }

    return null;
  }
}
