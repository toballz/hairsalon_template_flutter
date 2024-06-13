import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:webclient/h.dart';

///&**********************************************&
//https://github.com/afgprogrammer/Flutter-Login-Page-3/blob/master/lib/main.dart
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
        body: SingleChildScrollView(
            child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        gradient:
                            LinearGradient(begin: Alignment.topCenter, colors: [
                      Color.fromARGB(255, 21, 32, 54),
                      Color.fromARGB(255, 34, 59, 108),
                      Color.fromARGB(255, 51, 78, 132)
                    ])),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 80),
                          Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    FadeInUp(
                                        duration:
                                            const Duration(milliseconds: 1500),
                                        child: const Text("Login",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 40))),
                                    const SizedBox(height: 10),
                                    FadeInUp(
                                        duration:
                                            const Duration(milliseconds: 1300),
                                        child: const Text("Welcome Back",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18)))
                                  ])),
                          const SizedBox(height: 20),
                          Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(60),
                                      topRight: Radius.circular(60))),
                              child: Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Column(children: <Widget>[
                                    const SizedBox(height: 60),
                                    FadeInUp(
                                        duration:
                                            const Duration(milliseconds: 1400),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Color.fromARGB(
                                                          255, 40, 62, 104),
                                                      blurRadius: 20,
                                                      offset: Offset(0, 10))
                                                ]),
                                            child: Column(children: <Widget>[
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors.grey
                                                                .shade200)),
                                                  ),
                                                  child: TextField(
                                                      controller:
                                                          emailController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  "try@example.com",
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                              border:
                                                                  InputBorder
                                                                      .none))),
                                              Container(
                                                  padding: const EdgeInsets.all(
                                                      10),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors.grey
                                                                  .shade200))),
                                                  child: TextField(
                                                      controller:
                                                          passwordController,
                                                      obscureText: true,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  "Password",
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                              border:
                                                                  InputBorder
                                                                      .none)))
                                            ]))),
                                    const SizedBox(height: 40),
                                    FadeInUp(
                                        duration:
                                            const Duration(milliseconds: 1500),
                                        child: const Text("Forgot Password?",
                                            style:
                                                TextStyle(color: Colors.grey))),
                                    const SizedBox(height: 40),
                                    FadeInUp(
                                        duration:
                                            const Duration(milliseconds: 1500),
                                        child: MaterialButton(
                                            onPressed: () {
                                              Tools.login(
                                                  emailController.text,
                                                  passwordController.text,
                                                  context);
                                            },
                                            height: 50,
                                            color: const Color.fromARGB(
                                                255, 30, 54, 103),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: const Center(
                                                child: Text("Login",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight
                                                            .bold))))),
                                    const SizedBox(height: 50),
                                    FadeInUp(
                                        duration:
                                            const Duration(milliseconds: 1700),
                                        child: const Text(
                                            "Contact Developer to create Account",
                                            style:
                                                TextStyle(color: Colors.grey))),
                                    const SizedBox(height: 30),
                                    /* Row(
                          children: <Widget>[
                            Expanded(
                              child: FadeInUp(
                                duration: const Duration(milliseconds: 1800),
                                child: MaterialButton(
                                  onPressed: () {},
                                  height: 50,
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Facebook",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: FadeInUp(
                                duration: const Duration(milliseconds: 1900),
                                child: MaterialButton(
                                  onPressed: () {},
                                  height: 50,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  color: Colors.black,
                                  child: const Center(
                                    child: Text(
                                      "Github",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),*/
                                  ])))
                        ])))));
  }
}
