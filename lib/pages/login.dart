import 'dart:ui';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to", style: TextStyle(fontSize: 16)),
            const Text("reSentral", style: TextStyle(fontSize: 36)),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 47, 0, 35),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(286.0, 62.0)),
                    elevation: MaterialStateProperty.all(4.0),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 24)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    )),
                child: const Text("Get Started"),
              ),
            ),
            const Text("Developed by Jackson Ly",
                style: TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 200, 200, 200))),
          ],
        ),
      ),
    );
  }
}
