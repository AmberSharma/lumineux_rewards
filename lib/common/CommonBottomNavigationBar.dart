import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lumineux_rewards_app/Contactus.dart';
import 'package:lumineux_rewards_app/Dashboard.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../BaseConstants.dart';
import '../You.dart';

class CommonBottomNavigationBar extends StatefulWidget {
  const CommonBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CommonBottomNavigationBar> createState() =>
      _CommonBottomNavigationBarState();
}

class _CommonBottomNavigationBarState extends State<CommonBottomNavigationBar> {
  var pointsValue = "";
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/footer-image.jpg"), fit: BoxFit.fill),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.support_agent),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Contactus()),
                  );
                },
              ),
              const Text(
                BaseConstants.contactUsLabel,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          FloatingActionButton.extended(
            onPressed: () {
              // Add your onPressed code here!
            },
            label: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$pointsValue ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  BaseConstants.pointsLabel,
                  style: TextStyle(
                    color: Colors.lightGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.account_circle),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const You(),
                    ),
                  );
                },
              ),
              const Text(
                BaseConstants.youLabel,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getPoints() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      pointsValue =
          myFormat.format(int.parse(prefs.getString(BaseConstants.points)!));
    });
  }
}
