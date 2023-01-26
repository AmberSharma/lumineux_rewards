import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lumineux_rewards_app/ClaimConfirmation.dart';
import 'package:lumineux_rewards_app/showCustomDialogPopup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AddReceiptProject.dart';
import 'BaseConstants.dart';
import 'common/AppBarAction.dart';
import 'inc/Reward.dart';
import 'package:http/http.dart' as http;

class ClaimReward extends StatefulWidget {
  static String tag = "claim-reward";
  final Reward rewardList;
  const ClaimReward({super.key, required this.rewardList});

  @override
  State<ClaimReward> createState() => _ClaimRewardState();
}

class _ClaimRewardState extends State<ClaimReward> {
  var uuid = "";
  var points = "";
  var pointsLabel = "";

  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUuidPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Back",
          style: TextStyle(fontSize: 14.0),
        ),
        backgroundColor: Colors.lightGreen[900],
        actions: [
          AppBarAction(
            parentTag: ClaimReward.tag,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        // alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  widget.rewardList.name,
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: SizedBox.expand(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: widget.rewardList.url.isNotEmpty
                      ? Image.network(
                          widget.rewardList.url,
                          fit: BoxFit.fill,
                        )
                      : Image.asset(
                          "images/holding-img.png",
                        ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 15.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    widget.rewardList.description,
                    style: const TextStyle(
                        fontSize: 17.0,
                        // fontWeight: FontWeight.bold,
                        height: 1.5),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Center(
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: const TextStyle(
                              fontSize: 17.0,
                              color: Colors.black,
                              fontFamily: 'Montserrat'),
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Item value: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightGreen),
                            ),
                            TextSpan(
                                text:
                                    "${widget.rewardList.pointsLabel} points"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      RichText(
                        text: TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: const TextStyle(
                              fontSize: 17.0,
                              color: Colors.black,
                              fontFamily: 'Montserrat'),
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'You have: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightGreen),
                            ),
                            TextSpan(
                              text: "$pointsLabel ${BaseConstants.pointsLabel}",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Center(
                  child: Column(
                    children: [
                      int.parse(widget.rewardList.points) > int.parse(points)
                          ? Container()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 20),
                                backgroundColor: const Color(0xFFABCC59),
                              ),
                              onPressed: () async {
                                await showCustomDialogPopup<String?>(
                                  context,
                                  ClaimConfirmation(
                                    userUuid: uuid,
                                    itemUuid: widget.rewardList.uuid,
                                    userPoints: (int.parse(points) -
                                            int.parse(widget.rewardList.points))
                                        .toString(),
                                  ),
                                );
                              },
                              child: const Text('Claim now'),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getUuidPoints() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      uuid = prefs.getString("uuid")!;
      points = prefs.getString("points")!;
      pointsLabel = myFormat.format(int.parse(prefs.getString("points")!));
    });
  }
}
