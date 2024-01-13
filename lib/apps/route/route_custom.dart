import 'package:app_book/manage/bindings/admin_home_binding.dart';
import 'package:app_book/manage/bindings/book_binding.dart';
import 'package:app_book/manage/bindings/category_binding.dart';
import 'package:app_book/manage/bindings/favorite_book_binding.dart';
import 'package:app_book/manage/bindings/login_binding.dart';
import 'package:app_book/manage/bindings/nav_binding.dart';
import 'package:app_book/manage/bindings/pdf_view_binding.dart';
import 'package:app_book/manage/bindings/register_binding.dart';
import 'package:app_book/manage/bindings/setting_binding.dart';
import 'package:app_book/manage/bindings/user_setting_binding.dart';
import 'package:app_book/manage/middlewares/auth_middleware.dart';
import 'package:app_book/pages/appAdmin/addBookPage/add_book_page.dart';
import 'package:app_book/pages/appAdmin/addCategoryPage/add_category_page.dart';
import 'package:app_book/pages/appAdmin/adminBookPage/admin_book_page.dart';
import 'package:app_book/pages/appAdmin/adminCategoryPage/admin_category_page.dart';
import 'package:app_book/pages/appAdmin/adminPage/admin_page.dart';
import 'package:app_book/pages/appAdmin/editBookPage/edit_book_page.dart';
import 'package:app_book/pages/appAdmin/editCategoryPage/edit_category_page.dart';
import 'package:app_book/pages/appAdmin/navigator_admin_app_page.dart';
import 'package:app_book/pages/appAdmin/settingPage/setting_page.dart';
import 'package:app_book/pages/appUser/navigator_user_app_page.dart';
import 'package:app_book/pages/appUser/userCategoriesPage/userItemByCategoryPage/user_item_by_category_page.dart';
import 'package:app_book/pages/appUser/userCategoriesPage/user_categories_page.dart';
import 'package:app_book/pages/appUser/userFavoritePage/user_favorite_page.dart';
import 'package:app_book/pages/appUser/userHomePage/user_home_page.dart';
import 'package:app_book/pages/appUser/userPersonPage/user_person_page.dart';
import 'package:app_book/pages/loginPage/login_page.dart';
import 'package:app_book/pages/pdfViewPage/pdf_view_page.dart';
import 'package:app_book/pages/registerPage/register_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../pages/appAdmin/homePage/home_page.dart';
import '../../pages/appUser/userDetailBookPage/user_detail_book_page.dart';
import 'route_name.dart';

class RouterCustom {
  static List<GetPage> getPage = [
    GetPage(
      name: RouterName.login,
      page: () => const LoginPage(),
      binding: LoginBindings(),
      middlewares: [
        AuthMiddlewares(),
      ],
    ),
    GetPage(
      name: RouterName.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
      middlewares: [
        AuthMiddlewares(),
      ],
    ),
    GetPage(
      name: RouterName.nav,
      page: () => const NavigatorPage(),
      bindings: [
        NavBinding(),
        AdminHomeBinding(),
      ],
      middlewares: [
        AuthMiddlewares(),
      ],
    ),
    GetPage(
      name: RouterName.home,
      page: () => const HomePage(),
      binding: AdminHomeBinding(),
    ),
    GetPage(
      name: RouterName.admin,
      page: () => const AdminPage(),
    ),
    GetPage(
      name: RouterName.setting,
      page: () => const SettingPage(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: RouterName.adminBook,
      page: () => const AdminBookPage(),
      binding: BookBinding(),
    ),
    GetPage(
      name: RouterName.adminCategory,
      page: () => const AdminCategoryPage(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: RouterName.addBook,
      page: () => const AddBookPage(),
    ),
    GetPage(
      name: RouterName.addCaterogy,
      page: () => const AddCategoryPage(),
    ),
    GetPage(
      name: RouterName.editBook,
      page: () => const EditBookPage(),
    ),
    GetPage(
      name: RouterName.editCategory,
      page: () => const EditCategoryPage(),
    ),
    GetPage(
      name: RouterName.pdfView,
      page: () => const PdfViewerPage(),
      binding: PdfViewBinding(),
    ),
    //---------- User
    GetPage(
      name: RouterName.navUser,
      page: () => const NavigatorUserPage(),
      bindings: [
        BookBinding(),
        CategoryBinding(),
        FavoriteBookBinding(),
        SettingBinding(),
        UserSettingBinding(),
      ],
    ),
    GetPage(
      name: RouterName.userHome,
      page: () => const UserHomePage(),
      binding: BookBinding(),
    ),
    GetPage(
      name: RouterName.detailBook,
      page: () => const UserDetailBookPage(),
    ),
    GetPage(
      name: RouterName.userCategories,
      page: () => const UserCategoriesPage(),
    ),
    GetPage(
      name: RouterName.userBookWithCategory,
      page: () => const UserItemByCategoryPage(),
    ),
    GetPage(
      name: RouterName.userPerson,
      page: () => const UserPersonPage(),
      binding: UserSettingBinding(),
    ),
    GetPage(
      name: RouterName.userFavorite,
      page: () => const UserFavoritePage(),
      binding: FavoriteBookBinding(),
    )
  ];
}
