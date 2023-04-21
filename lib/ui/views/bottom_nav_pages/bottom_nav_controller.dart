// ignore_for_file: prefer_const_constructors

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../const/app_colors.dart';
import 'pages/card_screen.dart';
import 'pages/favourite_screen.dart';
import 'pages/home_screen.dart';
import 'pages/profile_screen.dart';

class BottomNavController extends StatelessWidget {
  BottomNavController({super.key});
  RxInt _initialIndex = 0.obs;

  final _pages = [
    HomeScreen(),
    FavouriteScreen(),
    CardScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => AnimatedNotchBottomBar(
        color: Colors.white38,
            pageController: PageController(
              initialPage: _initialIndex.value,
            ),
            bottomBarItems: [
              navItem(Icons.home_filled),
              navItem(Icons.favorite),
              navItem(Icons.business_center_outlined),
              navItem(Icons.person),
            ],
            onTap: (int value) {
              _initialIndex.value = value;
            },
          )),
      body: SafeArea(
        child: Obx(
          () => _pages[_initialIndex.value],
        ),
      ),
    );
  }
}

BottomBarItem navItem(inActiveIcon) {
  return BottomBarItem(
    inActiveItem: Icon(
      inActiveIcon,
      color: Colors.blueGrey,
    ),
    activeItem: Icon(
      inActiveIcon,
      color: AppColors.deep_orange,
    ),
  );
}
