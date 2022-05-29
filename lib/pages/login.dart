import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late AnimationController controller;
  late Animation fontAnimation;
  late Animation smallFontAnimation;

  String buttonText = "Get Started";
  String titleText = "Welcome to";

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    fontAnimation = Tween<double>(begin: 36.0, end: 24.0).animate(
        CurvedAnimation(
            parent: controller, curve: Curves.easeInOutCubicEmphasized));
    smallFontAnimation = Tween<double>(begin: 16.0, end: 14.0).animate(
        CurvedAnimation(
            parent: controller, curve: Curves.easeInOutCubicEmphasized));
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(titleText,
                style: TextStyle(fontSize: smallFontAnimation.value)),
            Text("reSentral", style: TextStyle(fontSize: fontAnimation.value)),
            buttonText == "Log In" ? const LoginCard() : Container(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 47, 0, 35),
              child: ElevatedButton(
                onPressed: () {
                  if (buttonText == "Log In" &&
                      _LoginCardState.userController.text != "" &&
                      _LoginCardState.passController.text != "") {}
                  setState(() {
                    buttonText = "Log In";
                    titleText = "Log in to";
                  });
                  controller.forward();
                },
                style: ButtonStyle(
                    fixedSize:
                        MaterialStateProperty.all(const Size(286.0, 62.0)),
                    elevation: MaterialStateProperty.all(4.0),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 24)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    )),
                child: Text(buttonText),
              ),
            ),
            const Text("Developed by Jackson Ly",
                style: TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 200, 200, 200))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Icon(FontAwesomeIcons.github,
                      color: Color.fromARGB(255, 200, 200, 200)),
                ),
                Text(" @JumpyJacko",
                    style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 200, 200, 200))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(FontAwesomeIcons.twitter,
                    color: Color.fromARGB(255, 200, 200, 200)),
                Text(" @JumpyJacko",
                    style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 200, 200, 200))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoginCard extends StatefulWidget {
  const LoginCard({Key? key}) : super(key: key);

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  static late TextEditingController userController;
  static late TextEditingController passController;

  late Animation sizeAnimation;
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    userController = TextEditingController();
    passController = TextEditingController();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    sizeAnimation = Tween<double>(begin: 0.0, end: 232.0).animate(
        CurvedAnimation(
            parent: controller, curve: Curves.easeInOutCubicEmphasized));
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeAnimation.value,
      width: 290,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
        child: Card(
          elevation: 4,
          color: Theme.of(context).colorScheme.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Container(
                width: 260,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 38),
                child: TextField(
                  controller: userController,
                  maxLines: 1,
                  autocorrect: false,
                  decoration: const InputDecoration(
                      labelText: "Username",
                      labelStyle: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(
                width: 260,
                child: TextField(
                  controller: passController,
                  maxLines: 1,
                  autocorrect: false,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: const TextStyle(fontSize: 16),
                    suffixIcon: IconButton(
                      icon: Icon(_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
