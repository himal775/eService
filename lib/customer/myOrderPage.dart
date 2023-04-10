// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class myOrderPage extends StatelessWidget {
//   const myOrderPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("My Order"),
//         ),
//         body: FutureBuilder<QuerySnapshot>(
//             future: FirebaseFirestore.instance.collection("Order").get(),
//             builder:
//                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               //Error Handling conditions
//               if (snapshot.hasError) {
//                 return const Text("Something went wrong");
//               }
//               if (snapshot.hasData) {
//                 return ListView(
//                     children:
//                         snapshot.data!.docs.map((DocumentSnapshot document) {
//                   Map<String, dynamic> data =
//                       document.data() as Map<String, dynamic>;
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: 150,
//                       width: double.infinity,
//                       decoration: const BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey,
//                               blurRadius: 3,
//                             )
//                           ],
//                           borderRadius: BorderRadius.all(Radius.circular(20))),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     const Icon(
//                                       Icons.person,
//                                       color: Colors.grey,
//                                     ),
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       "${data['workerName']}",
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 70,
//                                     ),
//                                     Row(
//                                       children: const [
//                                         Icon(
//                                           Icons.star,
//                                           color: Colors.yellow,
//                                         ),
//                                         Icon(
//                                           Icons.star,
//                                           color: Colors.yellow,
//                                         ),
//                                         Icon(
//                                           Icons.star,
//                                           color: Colors.yellow,
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(right: 8.0, left: 8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 const Icon(
//                                   Icons.phone,
//                                   color: Colors.grey,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     "${data['phoneNumber']}",
//                                     style: const TextStyle(fontSize: 16),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 8, right: 8),
//                             child: Row(
//                               children: [
//                                 const Icon(
//                                   Icons.location_on,
//                                   color: Colors.grey,
//                                 ),
//                                 Flexible(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                       "${data['workerLocation']}",
//                                       style: const TextStyle(fontSize: 16),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 8, right: 8),
//                             child: Row(
//                               children: [
//                                 Flexible(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                       "Total amount: ${data['totalAmount']}",
//                                       style: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList());
//               }
//               return const Text("");
//             }));
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Assume that we have a Firestore collection called 'users'
// and each document in this collection has a field called 'userId'
// that contains the user's ID, and a field called 'name' that
// contains the user's name.

final userId = FirebaseAuth.instance.currentUser!.uid;

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "My Orders",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: getUserDocumentSnapshot(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            } else {
              var userData = snapshot.data!.data() as Map<String, dynamic>;
              String name = userData['phoneNumber'];
              return Scaffold(
                appBar: AppBar(
                  title: Text('User: $name'),
                ),
                body: Center(
                  child: Text('Name: $name'),
                ),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Future<DocumentSnapshot> getUserDocumentSnapshot(String userId) async {
  // Get a reference to the Firestore collection
  CollectionReference usersRef = FirebaseFirestore.instance.collection('Order');

  // Query the collection for documents where the 'userId' field is equal to the given ID
  QuerySnapshot querySnapshot =
      await usersRef.where('userId', isEqualTo: userId).get();

  // Check if there are any documents in the query snapshot
  if (querySnapshot.docs.isNotEmpty) {
    // Retrieve the first matching document and return its snapshot
    return querySnapshot.docs.first;
  } else {
    // No matching document found
    throw Exception('You have no orders');
  }
}
