import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//declaring provider variable
final authprovider = Provider((ref) => AuthProvider());

class AuthProvider {
  //future function for user authentication using firebase

  Future<String> userlogin(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Successful";
    } on AsyncLoading {
      return "Loading..";
    } on FirebaseAuthException catch (error) {
      return "$error";
    }
  }

  Future<String> userSignup(

//future function for user signup using firebase authentication
      String fullName,
      String email,
      String password) async {
    try {
      final response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final uid = response.user!.uid;
      final userdata =
          FirebaseFirestore.instance.collection("userDetails").doc(uid);

      userdata.set({
        'FirstName': fullName,
        'email': email,
        'uid': uid,
      });
      return "Success";
    } on FirebaseAuthException catch (error) {
      return "$error";
    }
  }

  Future<String> workerSignUp(
      {
//future function for user signup using firebase authentication
      required String fullName,
      required String email,
      required String jobRole,
      required String experience,
      required String location,
      required String phoneNumber,
      required String password}) async {
    try {
      final response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final uid = response.user!.uid;
      final userdata = FirebaseFirestore.instance.collection(jobRole).doc(uid);

      userdata.set({
        'Id': uid,
        'FirstName': fullName,
        'email': email,
        'Ratings': 0,
        "Location": location,
        "Phone Number": phoneNumber,
        "Orders": [],
        'experience': experience,
        'uid': uid,
      });

      return "Success";
    } on FirebaseAuthException catch (error) {
      return "$error";
    }
  }
}
