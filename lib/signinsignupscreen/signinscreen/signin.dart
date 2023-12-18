import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_share/data/dummy_userdata.dart';
import 'package:ride_share/model/userdetails.dart';
import 'package:ride_share/services/firebase_auth_methods.dart';
import 'package:ride_share/signinsignupscreen/signinscreen/forgot_password.dart';
import 'package:ride_share/signinsignupscreen/signupscreen/signup.dart';
import 'package:ride_share/mainscreen/sumeetscreen.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });
  @override
  State<Login> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var username = '';
  var password = '';

  void _resetForm() {
    _formKey.currentState!.reset();
  }

  bool _passwordVisible = true;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  void loginUser() {
    context
        .read<FirebaseAuthMethods>()
        .loginWithEmail(email: username, password: password, context: context);
  }

  void _addItem() {
    final LoginDetailsmodel newItem =
        LoginDetailsmodel(username: username, password: password);
    setState(() {
      loginData.add(newItem);
    });
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(username);
      print(password);
      _addItem();
      loginUser();
      final user = context.read<FirebaseAuthMethods>().user;
      if (user.emailVerified) {
        _onMainScreen();
      }
    }
  }

  String contentValue = "login-page";
  void _onSignin() {
    setState(() {
      contentValue = "signin-page";
    });
  }

  void _onMainScreen() {
    setState(() {
      contentValue = "main-page";
    });
  }

  @override
  Widget build(context) {
    Widget content = Scaffold(
      appBar: AppBar(
        title: const Text("RideShare"),
        // actions: [
        //   IconButton(
        //     onPressed: _onMainScreen,
        //     icon: const Icon(
        //       Icons.close,
        //       color: Colors.blueAccent,
        //     ),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter your Email",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                maxLength: 50,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "sakec@gmail.com",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  counterText: "",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Invalid username";
                  }
                  return null;
                },
                onSaved: (value) {
                  username = value!;
                  print(username);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Enter your Password",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                maxLength: 50,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  hintText: "Sakec@123",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.5),
                  labelText: "Password",
                  counterText: "",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (_passwordVisible == false) {
                        setState(() {
                          _passwordVisible = true;
                        });
                      } else {
                        setState(() {
                          _passwordVisible = false;
                        });
                      }
                    },
                    child: Icon(_passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Entered password is wrong";
                  }
                  return null;
                },
                onSaved: (value) {
                  password = value!;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _resetForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 106, 22, 214),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15), //shape of button
                      ),
                    ),
                    child: const Text(
                      "Reset",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 106, 22, 214),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15), //shape of button
                      ),
                    ),
                    onPressed: _saveItem,
                    child: const Text(
                      "Sign In",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              //reset password
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const ForgotPasswordPage();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Not a Member? ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  TextButton(
                    onPressed: _onSignin,
                    child: const Text(
                      "Sign Up",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    if (contentValue == "signin-page") {
      content = const Signin();
    }
    if (contentValue == "main-page") {
      content = const Sumeet();
    }
    return content;
  }
}
