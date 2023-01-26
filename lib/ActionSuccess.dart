import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lumineux_rewards_app/Dashboard.dart';

import 'BaseConstants.dart';
import 'common/CommonAppBar.dart';
import 'common/CommonBottomNavigationBar.dart';
import 'inc/Reward.dart';

class ActionSuccess extends StatelessWidget {
  static String tag = "action-success";
  final String description;
  const ActionSuccess({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        parentTag: ActionSuccess.tag,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 22.0),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 25.0,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xffabcc59), // Background color
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Dashboard(),
                        ),
                      );
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const CommonBottomNavigationBar(),
    );
  }
}
