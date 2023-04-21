// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_project/ui/views/bottom_nav_pages/details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-favourite-items")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("items")
                  .snapshots(),
              builder: (context, snapshot) {
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
                        onTap: () => Get.to(
                            ProductDetailsScreen(product: documentSnapshot)),
                        child: Card(
                          elevation: 10,
                          child:
                              Image.network(documentSnapshot["product-img"][0]),
                        ),
                      );
                    });
              })),
    );
  }
}
