import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WorkerList extends StatelessWidget {
  final String workerType;

  const WorkerList({required this.workerType});

  @override
  Widget build(BuildContext context) {
    final student = FirebaseFirestore.instance.collection(workerType).get();

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        //Fetching data from the documentId specified of the student
        future: student,
        builder: (BuildContext context, snapshot) {
          //Error Handling conditions
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
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
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Himal Neupane",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.location_on,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "New Baneswor",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text("Rating"),
                        Container(
                          height: 35,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                            child: Text(
                              "Order",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }

          //Data is output to the user

          return Text("loading");
        },
      ),
    );
  }
}
