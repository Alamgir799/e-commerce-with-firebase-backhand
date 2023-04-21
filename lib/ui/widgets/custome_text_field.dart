import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/app_colors.dart';

customeTextField(
    keyboardType, controller, validate, icon, hintText, labelText) {
  Container(
    width: ScreenUtil().screenWidth,
    decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.all(Radius.circular(20.r))),
    child: TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      autofocus: true,
      validator: validate,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black38, fontSize: 20.sp),
        labelText: labelText,
        labelStyle: TextStyle(color: AppColors.deep_orange, fontSize: 20.sp),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
      ),
    ),
  );
}
