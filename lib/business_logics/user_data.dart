import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../ui/widgets/toast_message.dart';

addData(name, phone, date, gander, age) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser = _auth.currentUser;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("users-form-data");
  collectionReference
      .doc(currentUser!.email)
      .set({
        "name": name,
        "phone": phone,
        "date": date,
        "gander": gander,
        "age": age,
      })
      .then((value) => Utils().toastMessage("user data added"))
      .catchError((error) => Utils().toastMessage("something is wrong"));
}
