import 'package:flutter/material.dart';
import 'package:lumineux_rewards_app/Contactus.dart';
import 'package:lumineux_rewards_app/HowItWorks.dart';
import 'common/CommonAppBar.dart';
import 'package:lumineux_rewards_app/BaseConstants.dart';
import 'common/CommonBottomNavigationBar.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(),
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
                    onPressed: () {},
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HowItWorks()),
                      );
                    },
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Contactus()),
                      );
                    },
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
      bottomNavigationBar: const CommonBottomNavigationBar(),
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
}
