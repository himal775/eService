import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:online/customer/homePage.dart';
import 'package:online/customer/mainPage.dart';
import 'package:online/provider/authProvider.dart';
import 'package:online/customer/customerRegister.dart';
import 'package:online/provider/automaticLocation.dart';
import 'package:online/register.dart';
import 'package:online/worker/workerMain.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final _form = GlobalKey<FormState>();
  bool isTap = false;
  bool keepLogin = false;
  bool isCustomerLoading = false;
  bool isWorkerLoading = false;

  @override
  void initState() {
    super.initState();
    AutomaticAddress().getAddressFromLatLng();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Login Page",
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightGreen,
      ),
      body: Consumer(
        builder: ((context, ref, child) {
          return Form(
            key: _form,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Home eService",
                        style: TextStyle(
                          color: Colors.lightGreen,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Icon(
                    Icons.home_outlined,
                    size: 48,
                    color: Colors.lightGreen,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Email or Phone Number",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "Enter password";
                      } else {
                        return null;
                      }
                    }),
                    controller: usernameController,
                    decoration: const InputDecoration(
                        hintText: "Enter your email",
                        suffixIcon: Icon(Icons.supervised_user_circle),
                        isDense: true,
                        contentPadding: EdgeInsets.all(12),
                        border: OutlineInputBorder(
                            // borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.grey))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "Enter password";
                      } else {
                        return null;
                      }
                    }),
                    obscureText: !isTap,
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: "Enter your password",
                        suffixIcon: InkWell(
                          onTap: (() {
                            setState(() {
                              isTap = !isTap;
                            });
                          }),
                          child: isTap
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.all(12),
                        border: const OutlineInputBorder(
                            // borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.grey))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: keepLogin,
                          onChanged: (val) {
                            setState(() {
                              keepLogin = !keepLogin;
                            });
                          }),
                      const Text("Keep me login"),
                      const SizedBox(
                        width: 90,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forget Password?",
                            style: TextStyle(color: Colors.lightGreen),
                          ))
                    ],
                  ),
                  InkWell(
                    child: Container(
                      height: 45,
                      width: 1,
                      decoration: BoxDecoration(
                          color: Colors.lightGreen,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: isCustomerLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                            : const Text(
                                "Login as Customer",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                      ),
                    ),
                    onTap: () async {
                      _form.currentState!.save();

                      if (_form.currentState!.validate()) {
                        setState(() {
                          isCustomerLoading = true;
                        });
                        final response = await ref.read(authprovider).userlogin(
                            usernameController.text.trim(),
                            passwordController.text.trim());

                        if (response != "Successful") {
                          setState(() {
                            isCustomerLoading = false;
                          });
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: const Duration(seconds: 5),
                                content: Text(response)));
                          }
                        } else if (response == "Loading") {
                          Get.defaultDialog(middleText: "Loading..");
                        } else {
                          Get.to(() => MainPage(
                                index: 0,
                              ));
                          setState(() {
                            isCustomerLoading = false;
                          });
                        }
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Container(
                      height: 45,
                      width: 1,
                      decoration: BoxDecoration(
                          color: Colors.lightGreen,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: isWorkerLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                            : const Text(
                                "Login as Worker",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                      ),
                    ),
                    onTap: () async {
                      _form.currentState!.save();

                      if (_form.currentState!.validate()) {
                        setState(() {
                          isWorkerLoading = true;
                        });
                        final response = await ref.read(authprovider).userlogin(
                            usernameController.text.trim(),
                            passwordController.text.trim());

                        if (response != "Successful") {
                          setState(() {
                            isWorkerLoading = false;
                          });
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: const Duration(seconds: 5),
                                content: Text(response)));
                          }
                        } else if (response == "Loading") {
                          Get.defaultDialog(middleText: "Loading..");
                        } else {
                          Get.to(() => WorkerMainPage(
                                index: 0,
                              ));
                          setState(() {
                            isWorkerLoading = false;
                          });
                        }
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Don't have an Account?",
                      ),
                      TextButton(
                          onPressed: () {
                            Get.to(() => const Register());
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.lightGreen),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
