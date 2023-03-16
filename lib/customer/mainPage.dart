import 'package:flutter/material.dart';
import 'package:online/customer/homePage.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key, required this.index});
  int index;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  List pages = [
    const CustomerHomePage(),
    const CustomerHomePage(),
    const CustomerHomePage()
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.index,
          onTap: (value) {},
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_repair_service), label: "Service"),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: "Profile"),
          ]),
      body: pages.elementAt(widget.index),
    );
  }
}
