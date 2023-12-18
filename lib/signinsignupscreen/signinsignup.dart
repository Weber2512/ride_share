import 'package:flutter/material.dart';

import 'package:ride_share/signinsignupscreen/signinscreen/signin.dart';
import 'package:ride_share/signinsignupscreen/signupscreen/signup.dart';

class SigninLogin extends StatefulWidget {
  const SigninLogin({
    super.key,
  });
  @override
  State<SigninLogin> createState() {
    return _SigninLogin();
  }
}

class _SigninLogin extends State<SigninLogin> {
  var contentValue = "signinlogin-page";
  void _onSignin() {
    setState(() {
      contentValue = "signin-page";
    });
  }

  void _onLogin() {
    setState(() {
      contentValue = "login-page";
    });
  }

  @override
  Widget build(context) {
    Widget content = Scaffold(
      body: ListView(
        children: [
          Image.asset(
            "assets/images/carpool.png",
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            "Your pick of rides at low Prices",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 106, 22, 214),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), //shape of button
                ),
              ),
              onPressed: _onSignin,
              child: const Text(
                "Sign Up",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 106, 22, 214),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), //shape of button
                ),
              ),
              onPressed: _onLogin,
              child: const Text(
                " Sign In ",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
    if (contentValue == "signin-page") {
      content = const Signin();
    }

    if (contentValue == "login-page") {
      content = const Login();
    }

    return content;
  }
}
