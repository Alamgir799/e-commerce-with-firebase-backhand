// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_project/ui/widgets/custome_sizebox.dart';
import 'package:ecommerce_project/ui/widgets/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../const/app_colors.dart';
import '../../../const/app_string.dart';
import '../../widgets/custome_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  var product;
  ProductDetailsScreen({required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  var _dotPosition = 0;
  Future addToCard() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-cart-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "product-name": widget.product["product-name"],
      "product-price": widget.product["product-price"].toString(),
      "product-img": widget.product["product-img"],
      "product-description": widget.product["product-description"],
    }).then((value) => print("Added to cart"));
  }

  Future addToFavourite() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-favourite-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "product-name": widget.product["product-name"],
      "product-price": widget.product["product-price"].toString(),
      "product-img": widget.product["product-img"],
      "product-description": widget.product["product-description"],
    }).then((value) => print("Added to favourite"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(top: 40.h, left: 10.w, right: 10.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30.w,
                        color: AppColors.deep_orange,
                      )),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users-favourite-items")
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .collection("items")
                        .where("product-name",
                            isEqualTo: widget.product["product-name"])
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Text("");
                      }
                      return IconButton(
                          onPressed: () => snapshot.data.docs.length == 0
                              ? addToFavourite()
                              : Utils().toastMessage("already added"),
                          icon: snapshot.data.docs.length == 0
                              ? Icon(
                                  Icons.favorite_border_outlined,
                                  size: 30.w,
                                  color: AppColors.deep_orange,
                                )
                              : Icon(
                                  Icons.favorite,
                                  size: 30.w,
                                  color: AppColors.deep_orange,
                                ));
                    },
                  ),
                ],
              ),
              AspectRatio(
                aspectRatio: 2.0,
                child: CarouselSlider(
                    items: widget.product["product-img"]
                        .map<Widget>((item) => Padding(
                              padding: EdgeInsets.only(left: 10.w, right: 10.w),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(item),
                                        fit: BoxFit.fill)),
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
             20.ph,
              Align(
                alignment: Alignment.center,
                child: DotsIndicator(
                  dotsCount:
                      widget.product.length == 0 ? 1 : widget.product.length,
                  position: _dotPosition.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: AppColors.deep_orange,
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
             10.ph,
              Text(
                widget.product["product-name"],
                style: TextStyle(fontSize: 30.sp, color: AppColors.deep_orange),
              ),
             10.ph,
              Text(
                widget.product["product-description"],
                style: TextStyle(fontSize: 20.sp),
              ),
              10.ph,
              Text(
                widget.product["product-price"].toString(),
                style: TextStyle(fontSize: 30.sp, color: AppColors.deep_orange),
              ),
              30.ph,
              customButton(AppStrings.addToCard, () => addToCard()),
            ],
          ),
        ),
      )),
    );
  }
}
