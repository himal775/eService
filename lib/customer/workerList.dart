import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WorkerList extends StatelessWidget {
  final String workerType;

  const WorkerList({required this.workerType});

  @override
  Widget build(BuildContext context) {
    final student = FirebaseFirestore.instance.collection(workerType).get();

    return FutureBuilder(
      //Fetching data from the documentId specified of the student
      future: student,
      builder: (BuildContext context, snapshot) {
        //Error Handling conditions
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData) {
          return Text("Document does not exist");
        }

        //Data is output to the user
        if (snapshot.connectionState == ConnectionState.done) {
          // Map<String, dynamic> data =
          //     snapshot.data!.data() as Map<String, dynamic>;
          // return Text("Full Name: ${data['FirstName']} ${data['email']}");
        }

        return Text("loading");
      },
    );
  }
}
