// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_project/ui/views/bottom_nav_pages/bottom_nav_controller.dart';
import 'package:ecommerce_project/ui/views/bottom_nav_pages/pages/view_all_page/view_all.dart';
import 'package:get/get.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/sign_up.dart';
import '../views/bottom_nav_pages/details_screen.dart';
import '../views/bottom_nav_pages/search_screen.dart';
import '../views/splash/splash_screen.dart';
import '../views/user_form_data/user_data_screen.dart';

const String splash = '/splash-screen';
const String login = '/login-screen';
const String signUp = '/signUp-screen';
const String userData = '/userData-screen';
const String nav = '/nav-screen';
const String search = '/search-screen';
const String productScreen = '/product-screen';
const String viewall = '/viewall-screen';

List<GetPage> getPages = [
  GetPage(
    name: splash,
    page: () => SplashScreen(),
  ),
  GetPage(
    name: login,
    page: () => LoginScreen(),
  ),
  GetPage(
    name: signUp,
    page: () => SignUpScreen(),
  ),
  GetPage(
    name: userData,
    page: () => UserDataScreen(),
  ),
  GetPage(
    name: nav,
    page: () => BottomNavController(),
  ),
  GetPage(
    name: search,
    page: () => SearchScreen(),
  ),
  GetPage(
    name: productScreen,
    page: () => ProductDetailsScreen(
      product: Get.arguments,
    ),
  ),
  GetPage(
    name: viewall,
    page: () => ViewAllScreen(),
  ),
];
