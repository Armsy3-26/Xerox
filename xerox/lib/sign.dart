import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xerox/network.dart';

class RegisterManager extends StatefulWidget {
  const RegisterManager({Key? key}) : super(key: key);

  @override
  State<RegisterManager> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RegisterManager> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _accountNo = TextEditingController();
  final TextEditingController _sex = TextEditingController();
  final TextEditingController _language = TextEditingController();
  //final TextEditingController _bio = TextEditingController();
  //final TextEditingController _confirmPassword = TextEditingController();

  //dependency injection for the api

  NetworkController networkController = Get.put(NetworkController());

  //global key for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: ListView(children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              height: 120,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.transparent.withAlpha(52),
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                    image: AssetImage("assets/xerox.jpeg")),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 60,
                          width: 400,
                          child: Center(
                            child: TextFormField(
                                controller: _userName,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    hintText: "Enter username",
                                    filled: true,
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    fillColor: Colors.white),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter username";
                                  }
                                  return null;
                                }),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 60,
                          width: 400,
                          child: Center(
                            child: TextFormField(
                                controller: _accountNo,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    hintText: "Enter account Number",
                                    filled: true,
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    fillColor: Colors.white),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter account number";
                                  }
                                  return null;
                                }),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 60,
                          width: 400,
                          child: Center(
                            child: TextFormField(
                                controller: _sex,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    hintText: "Enter gender",
                                    filled: true,
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    fillColor: Colors.white),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter gender";
                                  }
                                  return null;
                                }),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 60,
                          width: 400,
                          child: Center(
                            child: TextFormField(
                                controller: _language,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    hintText: "Enter language",
                                    filled: true,
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    fillColor: Colors.white),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter language";
                                  }
                                  return null;
                                }),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          width: 350,
                          height: 50,
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue[600]),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(16.0))),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                networkController.sendDetails(
                                  _userName.text,
                                  int.parse(_accountNo.text),
                                  _sex.text,
                                  _language.text,
                                );
                              }
                            },
                            child: const Text(
                              " Register patient ",
                              style: TextStyle(color: Colors.black38),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ));
  }
}
