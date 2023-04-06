import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderProvider = Provider((ref) => OrderProvider());

class OrderProvider {
  Future<String> postOrder(
      {required String jobRole,
      required String docId,
      required String location,
      required String phoneNumber,
      required bool paymentStatus}) async {
    try {
      final userName = FirebaseAuth.instance.currentUser!.displayName;
      final userdb = FirebaseFirestore.instance.collection(jobRole).doc(docId);
      userdb.update({
        'order': FieldValue.arrayUnion([
          {
            "userName": userName,
            "location": location,
            "phoneNumber": phoneNumber,
            "paymentStatus": true,
            "paymentAmount": "10180"
          }
        ])
      });
      return "Success";
    } catch (err) {
      return "";
    }
  }
}
