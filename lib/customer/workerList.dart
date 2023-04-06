import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/customer/paymentPage.dart';

class WorkerList extends StatelessWidget {
  final String workerType;
  final String location;
  WorkerList({
    required this.workerType,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final student = FirebaseFirestore.instance.collection(workerType).get();

    return Scaffold(
      appBar: AppBar(
        title: Text(workerType),
      ),
      body: FutureBuilder<QuerySnapshot>(
        //Fetching data from the documentId specified of the student
        future: student,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //Error Handling conditions
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData) {
            return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  data['FirstName'],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     Row(
                      //       children: [
                      //         const Icon(
                      //           Icons.phone,
                      //           color: Colors.grey,
                      //         ),
                      //         const SizedBox(
                      //           width: 10,
                      //         ),
                      //         Text(
                      //           data['Phone Number'],
                      //           style: const TextStyle(
                      //             fontSize: 18,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => PaymentMethod(
                                    jobRole: workerType,
                                    location: location,
                                    phoneNumber: data['Phone Number'],
                                    docId: data['Id'],
                                  ));
                            },
                            child: Container(
                              height: 35,
                              width: 150,
                              decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: const Center(
                                child: Text(
                                  "Order",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 35,
                            width: 150,
                            decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: const Center(
                              child: Text(
                                "View details",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }).toList());
          }

          //Data is output to the user

          return Text("loading");
        },
      ),
    );
  }
}
