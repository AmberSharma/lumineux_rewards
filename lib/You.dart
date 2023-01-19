import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BaseConstants.dart';
import 'package:http/http.dart' as http;

class You extends StatefulWidget {
  const You({super.key});

  @override
  State<StatefulWidget> createState() {
    return YouForm();
  }
}

class YouForm extends State<You> {
  var uuid = "";
  var userName = "";
  var firstName = "";
  var lastName = "";
  var email = "";
  var mobile = "";
  var points = "";
  var address = "";

  String? _description;
  String? _name;
  String? _mobile;
  String? _email;
  String? _address;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildNameField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Your name*",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            TextFormField(
              initialValue: "$firstName $lastName",
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onSaved: (String? value) {
                _name = value;
              },
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Name is required";
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildCompanyField() {
  //   return Expanded(
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 24.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           const Align(
  //             alignment: Alignment.centerLeft,
  //             child: Text(
  //               "Company*",
  //               style: TextStyle(fontSize: 16.0),
  //             ),
  //           ),
  //           TextFormField(
  //             decoration: InputDecoration(
  //               contentPadding: EdgeInsets.zero,
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(20.0),
  //               ),
  //               filled: true,
  //               fillColor: Colors.white,
  //             ),
  //             onSaved: (String? value) {
  //               _company = value;
  //             },
  //             validator: (String? value) {
  //               if (value!.isEmpty) {
  //                 return "Name is required";
  //               }
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildPhoneField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Phone number*",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            TextFormField(
              initialValue: mobile,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onSaved: (String? value) {
                _mobile = value;
              },
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Name is required";
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Email address*",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            TextFormField(
              initialValue: email,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onSaved: (String? value) {
                _email = value;
              },
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Email is required";
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Delivery address*",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onSaved: (String? value) {
                _address = value;
              },
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Address is required";
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Cancel",
          style: TextStyle(fontSize: 14.0),
        ),
        backgroundColor: Colors.lightGreen[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alert),
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Row(
              children: const [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  child: Text(
                    "You",
                    style: TextStyle(
                      fontSize: 28.0,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  _buildNameField(),
                ],
              ),
            ),
            // Expanded(
            //   flex: 2,
            //   child: Row(
            //     children: [
            //       _buildCompanyField(),
            //     ],
            //   ),
            // ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  _buildPhoneField(),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  _buildEmailField(),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  _buildAddressField(),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xffabcc59), // Background color
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      final isValid = _formKey.currentState!.validate();

                      if (isValid) {
                        _formKey.currentState!.save();
                        // if (uuid.isNotEmpty) {
                        //   print(uuid);
                        //   var uri = Uri.parse(
                        //       "${BaseConstants.baseUrl}api/put/points-request/$uuid/");
                        //   var request = http.MultipartRequest("POST", uri);
                        //   request.fields['description'] = _description!;
                        //
                        //   request.send().then((response) async {
                        //     final respStr =
                        //         await response.stream.bytesToString();
                        //     print(respStr);
                        //     if (response.statusCode == 200)
                        //       print("Uploaded!");
                        //     else
                        //       print("fdsfsd");
                        //   });
                        // }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getUserDetails() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      uuid = prefs.getString("uuid")!;
      userName = prefs.getString("username")!;
      firstName = prefs.getString("first_name")!;
      lastName = prefs.getString("last_name")!;
      email = prefs.getString("email")!;
      mobile = prefs.getString("mobile")!;
      points = prefs.getString("points")!;
      address = prefs.getString("address")!;
    });
  }
}
