import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'BaseConstants.dart';

class CommonBottomNavigationBar extends StatefulWidget {
  const CommonBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CommonBottomNavigationBar> createState() =>
      _CommonBottomNavigationBarState();
}

class _CommonBottomNavigationBarState extends State<CommonBottomNavigationBar> {
  var pointsValue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPoints();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: BottomAppBar(
        color: Colors.lightGreen[800],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.home_filled),
                  iconSize: 25.0,
                  color: Colors.white,
                  onPressed: () {},
                ),
                const Text(BaseConstants.homeLabel),
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
                    pointsValue,
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
                  iconSize: 25.0,
                  color: Colors.white,
                  onPressed: () {},
                ),
                const Text(BaseConstants.youLabel),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getPoints() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      pointsValue = prefs.getString(BaseConstants.points)!;
    });
  }
}
