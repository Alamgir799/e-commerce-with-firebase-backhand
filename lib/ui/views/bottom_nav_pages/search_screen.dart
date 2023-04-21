import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_project/ui/views/bottom_nav_pages/details_screen.dart';
import 'package:ecommerce_project/ui/widgets/custome_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var inputText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
          child: Column(
          children: [
            TextFormField(
              onChanged: (val) {
                setState(() {
                  inputText = val;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r)),
              ),
            ),
            20.ph,
            Expanded(
                child: Container(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("products")
                      .where("product-name", isLessThanOrEqualTo: inputText)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot){
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("something is rang"),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Text("Loading"),
                      );
                    }
                    return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return InkWell(
                        onTap: (){
                          Get.to(ProductDetailsScreen(product:data));
                        },
                        child: Card(
                          elevation: 3,
                          child: ListTile(
                            title: Text(data["product-name"]),
                            leading: Image.network(data["product-img"][0]),
                          ),
                        ),
                      );
                    }).toList());
                  }),
            ))
          ],
        ),
      )),
    );
  }
}
