import 'package:flutter/material.dart';
import 'package:online/customer/homePage.dart';
import 'package:online/customer/myOrderPage.dart';
import 'package:online/customer/profilePage.dart';
import 'package:online/worker/workerHomePage.dart';
import 'package:online/worker/workerProfilePage.dart';

class WorkerMainPage extends StatefulWidget {
  WorkerMainPage({super.key, required this.index});
  int index;
  @override
  State<WorkerMainPage> createState() => _WorkerMainPageState();
}

class _WorkerMainPageState extends State<WorkerMainPage> {
  @override
  List pages = [const WorkerHomePage(), const WorkerProfilePage()];
  int selectedItem = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      selectedItem = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedItem,
          onTap: (value) {
            setState(() {
              selectedItem = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Order"),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: "Profile"),
          ]),
      body: pages.elementAt(selectedItem),
    );
  }
}
