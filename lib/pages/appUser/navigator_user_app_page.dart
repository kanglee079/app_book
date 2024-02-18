import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:app_book/pages/appUser/userCategoriesPage/user_categories_page.dart';
import 'package:app_book/pages/appUser/userFavoritePage/user_favorite_page.dart';
import 'package:app_book/pages/appUser/userHomePage/user_home_page.dart';
import 'package:app_book/pages/appUser/userPersonPage/user_person_page.dart';
import 'package:flutter/material.dart';

class NavigatorUserPage extends StatefulWidget {
  const NavigatorUserPage({super.key});

  @override
  State<NavigatorUserPage> createState() => _NavigatorUserPageState();
}

class _NavigatorUserPageState extends State<NavigatorUserPage> {
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomNavIndex,
        children: <Widget>[
          UserHomePage(),
          const UserCategoriesPage(),
          const UserFavoritePage(),
          const UserPersonPage(),
        ],
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Theme.of(context).hintColor,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        icons: const [
          Icons.home,
          Icons.category,
          Icons.favorite,
          Icons.person,
        ],
        activeColor: const Color(0xFFFF9900),
        iconSize: 30,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}
