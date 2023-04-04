import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "eHome Service",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Payment",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const ListTile(
              leading: Text(
                "Working Charge",
                style: TextStyle(color: Colors.blue),
              ),
              trailing: Text(
                "Rs 10,000",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const ListTile(
              leading: Text(
                "Delivery Charge",
                style: TextStyle(color: Colors.blue),
              ),
              trailing: Text("Rs 100"),
            ),
            const ListTile(
              leading: Text(
                "Tax",
                style: TextStyle(color: Colors.blue),
              ),
              trailing: Text("Rs 80"),
            ),
            const ListTile(
              leading: Text(
                "Total",
                style: TextStyle(color: Colors.blue),
              ),
              trailing: Text(
                "Rs 10,180",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Username",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              height: 30,
              width: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      isDense: true, contentPadding: EdgeInsets.all(8)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "PIN",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              height: 30,
              width: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      isDense: true, contentPadding: EdgeInsets.all(8)),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 80,
              decoration: BoxDecoration(
                  color: Color.fromARGB(220, 237, 23, 23),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Center(
                  child: Text(
                "Pay",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
            )
          ],
        ),
      ),
    );
  }
}
