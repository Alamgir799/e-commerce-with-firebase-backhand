// ignore_for_file: prefer_const_constructors

import 'package:date_time_picker/date_time_picker.dart';
import 'package:ecommerce_project/ui/widgets/custome_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../business_logics/user_data.dart';
import '../../../const/app_string.dart';
import '../../styles/styles.dart';
import '../../widgets/custome_button.dart';

class UserDataScreen extends StatefulWidget {
  UserDataScreen({Key? key}) : super(key: key);

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  TextEditingController _nameController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _dobController = TextEditingController();

  TextEditingController _genderController = TextEditingController();

  TextEditingController _ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<String> gender = ["Male", "Female", "Other"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(top: 30.h, left: 25.w, right: 25.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.submitForm,
                  style: AppStyles.myWelcomeTextStyle,
                ),
                Text(
                  AppStrings.weWillNotShare,
                  style: TextStyle(fontSize: 15.sp, color: Colors.black38),
                ),
                60.ph,
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  autofocus: true,
                  validator: (valu) {
                    if (valu!.isEmpty) {
                      return "name can't be empty";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: AppStrings.enterYourName,
                    hintStyle:
                        TextStyle(color: Colors.black38, fontSize: 20.sp),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                  ),
                ),
                20.ph,
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                  autofocus: true,
                  validator: (valu) {
                    if (valu!.isEmpty) {
                      return "phone number can't be empty";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: AppStrings.enterYourPhone,
                    hintStyle:
                        TextStyle(color: Colors.black38, fontSize: 20.sp),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                  ),
                ),
                20.ph,
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _dobController,
                  autofocus: true,
                  validator: (valu) {
                    if (valu!.isEmpty) {
                      return "date can't be empty";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () => DateTimePicker(
                              type: DateTimePickerType.dateTimeSeparate,
                              dateMask: 'd MMM, yyyy',
                              initialValue: DateTime.now().toString(),
                              firstDate: DateTime(1970),
                              lastDate: DateTime(2200),
                              icon: Icon(Icons.event),
                              dateLabelText: "",
                              timeLabelText: "",
                              selectableDayPredicate: (date) {
                                if (date.weekday == 6 || date.weekday == 7) {
                                  return false;
                                }
                                return true;
                              },
                              onChanged: (val) => print(val),
                              validator: (val) {
                                print(val);
                                return null;
                              },
                              onSaved: (val) => print(val),
                            ),
                        icon: Icon(
                          Icons.date_range_outlined,
                          size: 20.w,
                        )),
                    hintText: AppStrings.dateBirth,
                    hintStyle:
                        TextStyle(color: Colors.black38, fontSize: 20.sp),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                  ),
                ),
                20.ph,
                TextFormField(
                  controller: _genderController,
                  autofocus: true,
                  validator: (valu) {
                    if (valu!.isEmpty) {
                      return "gender can't be empty";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: DropdownButton<String>(
                      items: gender.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                          onTap: () {
                            setState(() {
                              _genderController.text = value;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                    hintText: AppStrings.gender,
                    hintStyle:
                        TextStyle(color: Colors.black38, fontSize: 15.sp),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                  ),
                ),
                20.ph,
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _ageController,
                  autofocus: true,
                  validator: (valu) {
                    if (valu!.isEmpty) {
                      return "age can't be empty";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: AppStrings.enterYourAge,
                    hintStyle:
                        TextStyle(color: Colors.black38, fontSize: 20.sp),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                  ),
                ),
                40.ph,
                customButton(AppStrings.submit, () {
                  addData(
                      _nameController.text,
                      _phoneController.text,
                      _dobController.text,
                      _genderController.text,
                      _ageController.text);
                  if (_formKey.currentState!.validate()) {
                    Get.toNamed("");
                  }
                }),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
