import 'package:flutter/material.dart';
import 'package:lumineux_rewards_app/AddReceiptProject.dart';
import 'showCustomDialogPopup.dart';
import 'BaseConstants.dart';
import 'inc/Reward.dart';

class RewardList extends StatefulWidget {
  const RewardList({super.key});

  @override
  State<StatefulWidget> createState() {
    return RewardListView();
  }
}

class RewardListView extends State<RewardList> {
  List<Reward> rewards = getJson();

  static List<Reward> getJson() {
    const data = [
      {
        "name": "iPad Mini Test",
        "points": "2000 Points",
        "url":
            "https://www.aptronixindia.com/media/catalog/product/cache/b5906e3ec4e5a6ce87664252573b40fe/i/p/ipad-mini-select-wifi-pink-202109_1.png",
      },
      {
        "name": "Amazon Gift Card",
        "points": "15000 Points",
        "url":
            "https://www.aptronixindia.com/media/catalog/product/cache/b5906e3ec4e5a6ce87664252573b40fe/i/p/ipad-mini-select-wifi-pink-202109_1.png",
      }
    ];

    return data.map<Reward>(Reward.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
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
              child: buildRewards(rewards),
            ),
            const Center(
              child: Text("It's rainy here"),
            ),
            const Center(
              child: Text("It's sunny here"),
            ),
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
                    children: const [
                      Text(
                        "20,000 ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
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
              //trailing: Icon(Icons.more_vert),
            ),
          );
        },
      );
}
