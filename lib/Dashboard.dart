import 'package:flutter/material.dart';
import 'package:lumineux_rewards_app/AddReceiptProject.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'showCustomDialogPopup.dart';
import 'package:lumineux_rewards_app/BaseConstants.dart';
import 'RewardList.dart';

class Dashboard extends StatelessWidget {
  static String tag = "dashboard";
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: const InitScreen(),
    );
  }
}

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  static const String POINTS = "points";
  var pointsValue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: () async {
                await showCustomDialogPopup<String?>(
                    context, const AddReceiptProject());
              },
            );
          },
        ),
        backgroundColor: Colors.lightGreen[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.home_filled),
                    iconSize: 100.0,
                    color: Colors.green,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RewardList()),
                      );
                    },
                  ),
                  const Text(BaseConstants.viewRewardsLabel),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.loyalty),
                    iconSize: 100.0,
                    color: Colors.green,
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                  const Text(BaseConstants.claimPointsLabel),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.contact_support),
                    iconSize: 100.0,
                    color: Colors.green,
                    onPressed: () {},
                  ),
                  const Text(BaseConstants.howItWorksLabel),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.support_agent),
                    iconSize: 100.0,
                    color: Colors.green,
                    onPressed: () {},
                  ),
                  const Text(BaseConstants.contactUsLabel),
                ],
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [],
          // )
        ],
      ),
      bottomNavigationBar: SizedBox(
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
      ),
      // drawer: Drawer(
      //   child: Row(
      //     children: [
      //       Column(
      //         children: [
      //           IconButton(
      //             icon: const Icon(Icons.contact_support),
      //             iconSize: 100.0,
      //             color: Colors.green,
      //             onPressed: () {},
      //           ),
      //           const Text("How it works"),
      //         ],
      //       ),
      //       Column(
      //         children: [
      //           IconButton(
      //             icon: const Icon(Icons.support_agent),
      //             iconSize: 100.0,
      //             color: Colors.green,
      //             onPressed: () {},
      //           ),
      //           const Text("Contact us"),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  void getPoints() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      pointsValue = prefs.getString("points")!;
    });
  }
}
