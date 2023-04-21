// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_project/ui/views/bottom_nav_pages/pages/view_all_page/view_all.dart';
import 'package:ecommerce_project/ui/widgets/custome_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../const/app_colors.dart';
import '../../../../const/app_string.dart';
import '../../../route/route.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _products = [];
  var _dotPosition = 0;
  List<String> _carouselImages = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  fetchCarouselImages() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(qn.docs[i]["img"]);
      }
    });
    return qn.docs;
  }

  fetchProducts() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("products").limit(6).get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "product-price": qn.docs[i]["product-price"],
          "product-img": qn.docs[i]["product-img"],
        });
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: SizedBox(
                    height: 60.h,
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: AppStrings.searchProduct,
                        hintStyle: TextStyle(fontSize: 15.sp),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0.r)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0.r)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      onTap: () => Get.toNamed(search),
                    ),
                  )),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: AppColors.deep_orange,
                      height: 60.h,
                      width: 60.w,
                      child: Center(
                        child: Icon(
                          Icons.search,
                          size: 30.w,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              20.ph,
              AspectRatio(
                aspectRatio: 2.0,
                child: CarouselSlider(
                    items: _carouselImages
                        .map((item) => Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(item),
                                        fit: BoxFit.fitWidth)),
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (val, carouselPageChangedReason) {
                          setState(() {
                            _dotPosition = val;
                          });
                        })),
              ),
              10.ph,
              DotsIndicator(
                dotsCount:
                    _carouselImages.length == 0 ? 1 : _carouselImages.length,
                position: _dotPosition.toDouble(),
                decorator: DotsDecorator(
                  activeColor: AppColors.deep_orange,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
              20.ph,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  AppStrings.topProduct,
                  style:
                      TextStyle(fontSize: 16.sp, color: AppColors.deep_orange),
                ),
                InkWell(
                  onTap: () => Get.toNamed(viewall),
                  child: Text(AppStrings.viewAll,
                      style: TextStyle(
                          fontSize: 16.sp, color: AppColors.deep_orange)),
                ),
              ]),
              20.ph,
              Expanded(
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 1),
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () => Get.toNamed(productScreen,
                              arguments: _products[index]),
                          child: Card(
                            elevation: 3,
                            child: Column(
                              children: [
                                AspectRatio(
                                    aspectRatio: 1.3,
                                    child: Image.network(
                                      _products[index]["product-img"][1],
                                      fit: BoxFit.scaleDown,
                                    )),
                                10.ph,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "${_products[index]["product-name"]}",
                                      style: TextStyle(fontSize: 15.sp),
                                    ),
                                    Text(
                                      "\$ ${_products[index]["product-price"].toString()}",
                                      style: TextStyle(
                                          color: AppColors.deep_orange,
                                          fontSize: 15.sp),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      })),
            ],
          ),
        ),
      ),
    ));
  }
}
