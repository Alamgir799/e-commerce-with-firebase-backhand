// ignore_for_file: prefer_const_constructors
import 'package:ecommerce_project/ui/widgets/custome_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../const/app_colors.dart';
import '../../../const/app_string.dart';
import '../../route/route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();
  chooseScreen() {
    var value = box.read('uid');
    if (value == null) {
      Get.toNamed(login);
    } else {
      Get.toNamed(nav);
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () => chooseScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deep_orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.ecommerce,
              style: TextStyle(
                  fontSize: 44.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            10.ph,
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
