import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_share/services/firebase_auth_methods.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({
    super.key,
  });
  @override
  State<ForgotPasswordPage> createState() {
    return _ForgotPasswordPage();
  }
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  var username = '';

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      passwordReset();
    }
  }

  void passwordReset() {
    context
        .read<FirebaseAuthMethods>()
        .passwordReset(email: username, context: context);
  }

  void _resetForm() {
    _formKey.currentState!.reset();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
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
                },
              ),
              const SizedBox(
                height: 10,
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
                      "Submit",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
