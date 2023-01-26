import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lumineux_rewards_app/ClaimReward.dart';
import 'package:lumineux_rewards_app/common/CommonBottomNavigationBar.dart';
import 'package:lumineux_rewards_app/common/LeadingAppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BaseConstants.dart';
import 'common/AppBarAction.dart';
import 'inc/Reward.dart';
import 'package:http/http.dart' as http;

class RewardList extends StatefulWidget {
  static String tag = "reward-list";
  const RewardList({super.key});

  @override
  State<StatefulWidget> createState() {
    return RewardListView();
  }
}

class RewardListView extends State<RewardList> {
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  List<Reward> firstTabRewardList = [];
  List<Reward> secondTabRewardList = [];
  List<Reward> thirdTabRewardList = [];

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
            AppBarAction(
              parentTag: RewardList.tag,
            )
          ],
          bottom: const TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 2.0),
            tabs: <Widget>[
              Tab(
                text: BaseConstants.firstTab,
              ),
              Tab(
                text: BaseConstants.secondTab,
              ),
              Tab(
                text: BaseConstants.thirdTab,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: buildRewards(firstTabRewardList),
            ),
            Center(
              child: buildRewards(secondTabRewardList),
            ),
            Center(
              child: buildRewards(thirdTabRewardList),
            ),
          ],
        ),
        bottomNavigationBar: const CommonBottomNavigationBar(),
      ),
    );
  }

  Widget buildRewards(List<Reward> rewards) => rewards.isEmpty
      ? const SpinKitRing(
          color: Colors.green,
        )
      : ListView.builder(
          itemCount: rewards.length,
          itemBuilder: (context, index) {
            final reward = rewards[index];
            return Card(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: reward.url.isNotEmpty
                      ? Image.network(
                          reward.url,
                          width: 50,
                          height: 50,
                          fit: BoxFit.fill,
                        )
                      : Image.asset(
                          "images/holding-img.png",
                        ),
                ),
                title: Text(reward.name),
                subtitle: Text(reward.pointsLabel),
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
        List firstTabRewardJson = [];
        List secondTabRewardJson = [];
        List thirdTabRewardJson = [];
        for (var item in data) {
          print(item["col_name"]);
          if (item["col_name"] == BaseConstants.firstTab) {
            firstTabRewardJson.add({
              "uuid": item["uuid"],
              "name": item["name"],
              "points": item["points"],
              "pointsLabel": myFormat.format(int.parse(item["points"])),
              "url": item.containsKey("thu") ? item["thu"][0] : "",
              "description": item["description"]
            });
          } else if (item["col_name"] == BaseConstants.secondTab) {
            secondTabRewardJson.add({
              "uuid": item["uuid"],
              "name": item["name"],
              "points": item["points"],
              "pointsLabel": myFormat.format(int.parse(item["points"])),
              "url": item.containsKey("thu") ? item["thu"][0] : "",
              "description": item["description"]
            });
          } else {
            thirdTabRewardJson.add({
              "uuid": item["uuid"],
              "name": item["name"],
              "points": item["points"],
              "pointsLabel": myFormat.format(int.parse(item["points"])),
              "url": item.containsKey("thu") ? item["thu"][0] : "",
              "description": item["description"]
            });
          }
        }
        setState(() {
          firstTabRewardList =
              firstTabRewardJson.map<Reward>(Reward.fromJson).toList();
          secondTabRewardList =
              secondTabRewardJson.map<Reward>(Reward.fromJson).toList();
          thirdTabRewardList =
              thirdTabRewardJson.map<Reward>(Reward.fromJson).toList();
        });
      }
    }
  }
}
