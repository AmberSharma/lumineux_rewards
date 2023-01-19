import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lumineux_rewards_app/ClaimReward.dart';
import 'package:lumineux_rewards_app/common/CommonBottomNavigationBar.dart';
import 'package:lumineux_rewards_app/common/LeadingAppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BaseConstants.dart';
import 'inc/Reward.dart';
import 'package:http/http.dart' as http;

class RewardList extends StatefulWidget {
  const RewardList({super.key});

  @override
  State<StatefulWidget> createState() {
    return RewardListView();
  }
}

class RewardListView extends State<RewardList> {
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  List<Reward> rewardList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRewardList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const LeadingAppBar(),
          backgroundColor: Colors.lightGreen[900],
          actions: [
            IconButton(
              icon: const Icon(Icons.add_alert),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 2.0),
            tabs: <Widget>[
              Tab(
                text: BaseConstants.obtainableNowLabel,
              ),
              Tab(
                text: BaseConstants.latestLabel,
              ),
              Tab(
                text: BaseConstants.allLabel,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: buildRewards(rewardList),
            ),
            const Center(
              child: Text("It's rainy here"),
            ),
            const Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
        bottomNavigationBar: const CommonBottomNavigationBar(),
      ),
    );
  }

  Widget buildRewards(List<Reward> rewards) => ListView.builder(
        itemCount: rewards.length,
        itemBuilder: (context, index) {
          final reward = rewards[index];
          return Card(
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffE5E5E5),
                  ),
                  color: const Color(0xffE5E5E5),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Image.network(reward.url),
              ),
              title: Text(reward.name),
              subtitle: Text(reward.points),
              onTap: () {
                Reward argument = Reward(
                    name: reward.name,
                    points: reward.points,
                    pointsLabel: reward.pointsLabel,
                    url: reward.url,
                    uuid: reward.uuid,
                    description: reward.description);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClaimReward(
                      rewardList: argument,
                    ),
                  ),
                );

                // Navigator.push(
                //   context,
                //   ClaimReward.tag,
                //   arguments: Reward(
                //     name: reward.name,
                //     points: reward.points,
                //     url: reward.url,
                //     uuid: reward.uuid,
                //   ),
                // );
              },
            ),
          );
        },
      );

  void getRewardList() async {
    var prefs = await SharedPreferences.getInstance();
    var uuid = prefs.getString(BaseConstants.uuid)!;
    var url = BaseConstants.baseUrl + BaseConstants.getRewardUrl + uuid;
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print(responseData);
      if (responseData["status"] == "success") {
        List data = responseData["data"];
        List rewardJson = [];
        for (var item in data) {
          rewardJson.add({
            "uuid": item["uuid"],
            "name": item["name"],
            "points": item["points"],
            "pointsLabel": myFormat.format(int.parse(item["points"])),
            "url": item["thu"][0],
            "description": item["description"]
          });
        }
        setState(() {
          rewardList = rewardJson.map<Reward>(Reward.fromJson).toList();
        });
      }
    }
  }
}
