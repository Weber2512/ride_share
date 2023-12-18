import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeedbackState extends StatefulWidget {
  const FeedbackState({super.key});
  @override
  State<FeedbackState> createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedbackState> {
  final _key = GlobalKey<FormState>();
  var enteredname = "";
  var enteredage = "";
  var enteredemail = '';
  var enteredcontent = '';
  var enteredgender = "";

  void _reset() {
    _key.currentState!.reset();
  }

  void _submitdata() {
    _key.currentState!.validate();
    _key.currentState!.save();
    print(enteredname);
    print(enteredgender);

    final url = Uri.https(
        'fir-auth-19e30-default-rtdb.firebaseio.com', 'feedback.json');
    http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'name': enteredname,
          'age': enteredage,
          'email': enteredemail,
          'content': enteredcontent,
          'gender': enteredgender,
        },
      ),
    );
    _reset();
    const (
      content: Text("feedback successfully submitted"),
      duration: Duration(seconds: 5),
    );
  }

  final List<String> _gender = [
    'Male',
    'Female',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Feedback'),
      ),
      body: ListView(
        children: [
          Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text('Your Name'),
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                    keyboardType: TextInputType.name,
                    maxLength: 50,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1) {
                        return 'Invalid Name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      enteredname = value!;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                    width: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                          items: [
                            for (final i in _gender)
                              DropdownMenuItem(
                                value: i,
                                child: Text(i),
                              )
                          ],
                          onChanged: (value) {},
                          decoration: const InputDecoration(
                            label: Text(
                              'Gender',
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                          onSaved: (value) {
                            enteredgender = value!;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                              label: Text('Your Age'),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)))),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length <= 1) {
                              return 'Invalid Age, must be Positive';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            enteredage = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                    width: 15,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        counterText: "",
                        label: Text('Your Email'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 100,
                    // key: _key,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1) {
                        return 'Enter your proper Email-Id!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      enteredemail = value!;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                    width: 15,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text('What do you want us to work on?'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                    keyboardType: TextInputType.name,
                    maxLength: 100,
                    // key: _key,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1) {
                        return 'Enter proper reason';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      enteredcontent = value!;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: _reset,
                        child: const Text(
                          'Reset',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      ElevatedButton(
                        onPressed: _submitdata,
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
