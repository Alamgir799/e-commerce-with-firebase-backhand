// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_project/ui/views/bottom_nav_pages/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../const/app_colors.dart';

class ViewAllScreen extends StatefulWidget {
  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("products").snapshots(),
          builder: (_, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("something is rang"),
              );
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                var documentSnapshot = snapshot.data!.docs[index].data();
                return InkWell(
                  onTap: () {
                    Get.to(
                        ProductDetailsScreen(product: documentSnapshot));
                  },
                  child: Card(
                    elevation: 10,
                    child: Image.network(documentSnapshot["product-img"][1]),
                  ),
                );
              },
            );
          }),
    );
  }
}
