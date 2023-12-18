import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';
import 'package:ride_share/model/userdetails.dart';
import 'package:ride_share/services/firebase_auth_methods.dart';
import 'package:ride_share/signinsignupscreen/signinscreen/signin.dart';
import 'package:ride_share/mainscreen/sumeetscreen.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ride_share/data/dummy_userdata.dart';
import 'package:http/http.dart' as http;

//import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

final formatter = DateFormat.yMd();

class Signin extends StatefulWidget {
  const Signin({
    super.key,
  });
  @override
  State<Signin> createState() {
    return _Signin();
  }
}

class _Signin extends State<Signin> {
  final _formKey = GlobalKey<FormState>();

  var password = "";
  var email = "";
  var firstName = '';
  var lastName = '';
  late PhoneNumber contact;
  DateTime? selectedDate;

  // Future addUserDetails(String email, String firstName, String lastName,
  //     num contact, num date, String password) async {
  //   await FirebaseFirestore.instance.collection('user').add({
  //     'email': email,
  //     'firstName': firstName,
  //     'lastName': lastName,
  //     'contact': contact,
  //     'date': date,
  //     'password': password
  //   });
  // }

  void signUpUser() async {
    context
        .read<FirebaseAuthMethods>()
        .signUpWithEmail(email: email, password: password, context: context);
  }

  void _addItem() {
    final UserDetails newItem = UserDetails(
        firstName: firstName,
        lastName: lastName,
        contact: contact,
        date: selectedDate!,
        emial: email,
        password: password);
    // addUserDetails(email, firstName, lastName, contact as num,
    //     selectedDate as num, password);
    // CollectionReference collRef = FirebaseFirestore.instance.collection('user');
    // collRef.add({
    //   'email': _email,
    //   'firstName': _firstName,
    //   'lastName': _lastName,
    //   'contact': _contact,
    //   'date': _selectedDate!,
    //   'password': _password
    // });
    final LoginDetailsmodel newlogin =
        LoginDetailsmodel(username: email, password: password);

    setState(() {
      userData.add(newItem);
      loginData.add(newlogin);
      print("signup data added along with login");
      print(userData.length);
      print(loginData.length);
    });
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      if (selectedDate == null) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text("Invalid Input"),
                content: const Text(
                    "Please make sure you enter the valid date was entered."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("OK"))
                ],
              );
            });
        return;
      }
      _formKey.currentState!.save();
      _addItem();

      signUpUser();
      final url =
          Uri.https('fir-auth-19e30-default-rtdb.firebaseio.com', 'user.json');
      http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'email': email,
            'firstName': firstName,
            'lastName': lastName,
            'contact': contact,
            'date': selectedDate!,
            'password': password
          },
        ),
      );
      final user = context.read<FirebaseAuthMethods>().user;
      if (user.emailVerified) {
        _onMainScreen();
      }
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
  }

  bool _passwordVisible = true;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 40, now.month, now.day);

    final pickedData = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      selectedDate = pickedData;
    });
  }

  String contentValue = "Sigin-page";
  void _onLogin() {
    setState(() {
      contentValue = "login-page";
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
        //   )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            const Text(
              "Enter your Email Id.",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              maxLength: 50,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                label: Text("Email Id"),
                hintText: "name@gmail.com",
                counterText: "",
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              validator: Validators.compose([
                Validators.required('Email is required'),
                Validators.email('Invalid email address'),
              ]),
              onSaved: (value) {
                email = value!;
              },
            ),
            const SizedBox(
              height: 5,
            ),
            const Text("Enter your Contact Number.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 5,
            ),
            IntlPhoneField(
              keyboardType: TextInputType.phone,
              dropdownIconPosition: IconPosition.trailing,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                counterText: "",
                hintText: "8169708105",
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'IN',
              textAlign: TextAlign.start,
              validator: (value) {
                if (value.toString().length < 10) {
                  return "Contact number should be of 10 digits";
                }
                return null;
              },
              onSaved: (value) {
                contact = value!;
              },
            ),
            const SizedBox(
              height: 5,
            ),
            const Text("What's your name?",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text("First Name"),
                      hintText: "Jignesh",
                      counterText: "",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1 ||
                          value.trim().length > 50) {
                        return "Must Be Between 1 to 50 Characters";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      firstName = value!;
                    },
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: TextFormField(
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text("Last Name"),
                      counterText: "",
                      hintText: "Panchal",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1 ||
                          value.trim().length > 50) {
                        return "Must Be Between 1 to 50 Characters";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      lastName = value!;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Text("Define your password.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      label: const Text("Password"),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
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
                    validator: Validators.compose([
                      Validators.required('Password is required'),
                      Validators.patternString(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                          'Invalid Password')
                    ]),
                    onSaved: (value) {
                      password = value!;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Text("What's your date of birth?",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 5),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    selectedDate == null
                        ? "No Date Selected"
                        : formatter.format(selectedDate!),
                  ),
                  IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month)),
                ]),
            const SizedBox(
              height: 5,
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
                      borderRadius: BorderRadius.circular(15), //shape of button
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
                      borderRadius: BorderRadius.circular(15), //shape of button
                    ),
                  ),
                  onPressed: _saveItem,
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Already a Member? ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                TextButton(
                  onPressed: _onLogin,
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
    if (contentValue == "login-page") {
      content = const Login();
    }
    if (contentValue == "main-page") {
      content = const Sumeet();
    }
    return content;
  }
}
