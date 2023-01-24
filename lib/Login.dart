import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lumineux_rewards_app/BaseConstants.dart';
import 'package:lumineux_rewards_app/Dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:lumineux_rewards_app/inc/UserInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static String tag = "login-page";
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? _username;
  String? _password;

  bool? waitingForApiResponse = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var logo = const Hero(
      tag: 'hero',
      child: Center(
        child: CircleAvatar(
          backgroundImage: AssetImage("images/app_icon.png"),
        ),
      ),
    );

    final username = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: "Username",
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      onSaved: (String? value) {
        setState(() {
          _username = value;
        });
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Username is required";
        }
      },
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Password",
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      onSaved: (String? value) {
        setState(() {
          _password = value;
        });
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Password is required";
        }
      },
    );

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        //elevation: 5.0,
        child: MaterialButton(
          minWidth: 100.0,
          height: 42.0,
          onPressed: () async {
            final isValid = _formKey.currentState!.validate();

            if (isValid) {
              _formKey.currentState!.save();

              setState(() {
                waitingForApiResponse = true;
              });

              var parameters = "/0/${_username!}/${_password!}";
              http.Response response = await http.get(Uri.parse(
                  BaseConstants.baseUrl +
                      BaseConstants.getInfoUrl +
                      parameters));

              if (response.statusCode == 200) {
                var responseData = jsonDecode(response.body);

                if (responseData["status"] == "success") {
                  var data = responseData["data"];
                  var prefs = await SharedPreferences.getInstance();
                  await prefs.setString('uuid', data["uuid"]);
                  await prefs.setString('user_name', data["username"]);
                  await prefs.setString('first_name', data["first_name"]);
                  await prefs.setString('last_name', data["last_name"]);
                  await prefs.setString('email', data["email"]);
                  await prefs.setString('mobile', data["mobile"]);
                  await prefs.setString('points', data["points"]);
                  await prefs.setString('address', data["address"]);
                  await prefs.setString('company', data["comp_name"]);
                  await prefs.setString(
                      'reward_img', data["img"]["dash_banner_1"]);
                  print(prefs.getString('uuid'));
                  Navigator.of(context).pushNamed(Dashboard.tag);
                }
                //return responseToParent[{"success": false, "message": responseData["type"] }];
              } else {
                setState(() {
                  waitingForApiResponse = false;
                });
              }
            }
          },
          color: const Color(0xffabcc59),
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: waitingForApiResponse == true
          ? const SpinKitPouringHourGlassRefined(
              color: Colors.green,
            )
          : Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  children: [
                    logo,
                    const SizedBox(
                      height: 48.0,
                    ),
                    username,
                    const SizedBox(
                      height: 8.0,
                    ),
                    password,
                    const SizedBox(
                      height: 24.0,
                    ),
                    loginButton
                  ],
                ),
              ),
            ),
    );
  }
}
