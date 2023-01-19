import 'package:flutter/material.dart';
import 'package:lumineux_rewards_app/AddProject.dart';
import 'package:lumineux_rewards_app/AddReceipt.dart';
import 'package:lumineux_rewards_app/Contactus.dart';
import 'package:lumineux_rewards_app/HowItWorks.dart';
import 'package:lumineux_rewards_app/showCustomDialogPopup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddReceiptProject.dart';
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
  var rewardImage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRewardIconImage();
  }

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
                    icon: Image.asset('images/icon-receipt.png'),
                    iconSize: 100.0,
                    color: Colors.green,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddReceipt()),
                      );
                    },
                  ),
                  const Text(BaseConstants.addReceiptLabel),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Image.asset('images/icon-project.png'),
                    iconSize: 100.0,
                    color: Colors.green,
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddProject()),
                      );
                    },
                  ),
                  const Text(BaseConstants.addProjectLabel),
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
                    icon: Image.asset('images/icon-rewards.png'),
                    iconSize: 100.0,
                    color: Colors.green,
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RewardList()),
                      );
                    },
                  ),
                  const Text(BaseConstants.claimPointsLabel),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Image.asset('images/icon-how.png'),
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
            ],
          ),
        ],
      ),
      bottomNavigationBar: const CommonBottomNavigationBar(),
    );
  }

  void getRewardIconImage() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      rewardImage = prefs.getString("reward_img")!;
    });
  }
}
