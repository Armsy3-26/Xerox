import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xerox/Api/api.dart';

class RegisterManager extends StatefulWidget {
  const RegisterManager({Key? key}) : super(key: key);

  @override
  State<RegisterManager> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RegisterManager> {
  final TextEditingController _employeeNo = TextEditingController();
  final TextEditingController _password = TextEditingController();
  //final TextEditingController _confirmPassword = TextEditingController();

  //dependency injection for the api

  NetworkController networkController = Get.put(NetworkController());

  //global key for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    networkController.getLearningInstitutions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
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
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 60,
                          width: 400,
                          child: Center(
                            child: TextFormField(
                                controller: _employeeNo,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    hintText: "Enter MOE Number",
                                    filled: true,
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    fillColor: Colors.white),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter MOE number";
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
                                controller: _password,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    hintText: "Enter password",
                                    filled: true,
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    fillColor: Colors.white),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter password";
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
                                    WidgetStateProperty.all(Colors.blue[600]),
                                foregroundColor:
                                    WidgetStateProperty.all(Colors.white),
                                padding: WidgetStateProperty.all(
                                    const EdgeInsets.all(16.0))),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // networkController.sendDetails(
                                //   _employeeNo.text,
                                //   _password.text,
                                // );
                              }
                            },
                            child: const Text(
                              " Get in ",
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
