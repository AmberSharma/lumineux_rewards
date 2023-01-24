import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lumineux_rewards_app/Dashboard.dart';
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
  int apiCall = 0;
  String? _uuid;
  String? _name;
  String? _email;
  String? _company;
  String? _mobile;
  String? _userName;
  String? _address;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildNameField() {
    return Padding(
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
            key: Key(_name.toString()),
            initialValue: _name,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(width: 1, color: Colors.blueGrey),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onSaved: (String? value) {
              _name = value!;
            },
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Name is required";
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Company*",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          TextFormField(
            readOnly: true,
            key: Key(_company.toString()),
            initialValue: _company,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onSaved: (String? value) {
              _company = value;
            },
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Company is required";
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
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
            key: Key(_mobile.toString()),
            initialValue: _mobile,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              //filled: true,
              //fillColor: Colors.white,
            ),
            onSaved: (String? value) {
              _mobile = value;
            },
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Phone number is required";
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return Padding(
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
            key: Key(_email.toString()),
            initialValue: _email,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
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
    );
  }

  Widget _buildAddressField() {
    return Padding(
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
            // minLines: 5,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            key: Key(_address.toString()),
            initialValue: _address,
            decoration: InputDecoration(
              // contentPadding: EdgeInsets.zero,
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
          onPressed: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Dashboard())),
        ),
        title: const Text(
          "Cancel",
          style: TextStyle(fontSize: 14.0),
        ),
        backgroundColor: Colors.lightGreen[900],
        actions: [
          TextButton.icon(
            icon: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 16),
            ),
            onPressed: () async {
              final isValid = _formKey.currentState!.validate();

              if (isValid) {
                setState(() {
                  apiCall = 1;
                });
                _formKey.currentState!.save();
                var parameters = "$_uuid/";
                var url = BaseConstants.baseUrl +
                    BaseConstants.putUserInfoUrl +
                    parameters;
                http.Response response = await http.post(Uri.parse(url), body: {
                  'name': _name,
                  'email': _email,
                  'address': _address,
                  'mobile': _mobile
                });
                if (response.statusCode == 200) {
                  var responseData = jsonDecode(response.body);
                  if (!mounted) return;

                  var snackBar = SnackBar(
                    content: Text(responseData["status_msg"]),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  setState(() {
                    apiCall = 0;
                  });
                  if (responseData["status"] == "success") {
                    String name = _name.toString();
                    int idx = name.indexOf(" ");
                    List parts = [
                      name.substring(0, idx).trim(),
                      name.substring(idx + 1).trim()
                    ];

                    var prefs = await SharedPreferences.getInstance();
                    await prefs.setString('first_name', parts[0]);
                    await prefs.setString('last_name', parts[1]);
                    await prefs.setString('email', _email!);
                    await prefs.setString('mobile', _mobile!);
                    await prefs.setString('address', _address!);
                  }
                }
              }
            },
            label: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: apiCall == 1
          ? const SpinKitPouringHourGlassRefined(
              color: Colors.green,
            )
          : Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
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
                    child: CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                            children: [
                              _buildNameField(),
                              _buildCompanyField(),
                              _buildPhoneField(),
                              _buildEmailField(),
                              _buildAddressField()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: 'Username: ',
                                  style: TextStyle(fontSize: 20.0)),
                              TextSpan(
                                  text: _userName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0)),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xffabcc59), // Background color
                          ),
                          child: const Text(
                            "Manage Password",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            // final isValid = _formKey.currentState!.validate();
                            //
                            // if (isValid) {
                            //   _formKey.currentState!.save();
                            // }
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
      _uuid = prefs.getString("uuid")!;
      _userName = prefs.getString("user_name")!;
      _name =
          "${prefs.getString("first_name")!} ${prefs.getString("last_name")!}";
      _email = prefs.getString("email")!;
      _mobile = prefs.getString("mobile")!;
      _company = prefs.getString("company")!;
      _address = prefs.getString("address")!;
    });

    print(_name);
  }
}
