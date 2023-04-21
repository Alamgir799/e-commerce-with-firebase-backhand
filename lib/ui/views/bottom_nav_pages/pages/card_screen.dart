
// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_project/ui/views/bottom_nav_pages/details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../const/app_colors.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users-cart-items")
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection("items")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if (snapshot.hasError) {
                    return Center(
                      child: Text("something is rong"),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (_, index) {
                        DocumentSnapshot _doc =
                        snapshot.data!.docs[index];
                        return InkWell(
                          onTap: (){
                            Get.to(ProductDetailsScreen(product:_doc.data()));
                          },
                          child: Card(
                            elevation: 3,
                            child: ListTile(
                              leading: Text(_doc["product-name"]),
                              title: Text(
                                "\$ ${_doc["product-price"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                    color: AppColors.deep_orange),
                              ),
                              trailing: GestureDetector(
                                child: CircleAvatar(
                                  child: IconButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection("users-cart-items")
                                            .doc(FirebaseAuth
                                            .instance.currentUser!.email)
                                            .collection("items")
                                            .doc(_doc.id)
                                            .delete();
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                        size: 20.w,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }))
    );
  }
}


