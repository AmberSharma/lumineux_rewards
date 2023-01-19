import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lumineux_rewards_app/ClaimConfirmation.dart';
import 'package:lumineux_rewards_app/showCustomDialogPopup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AddReceiptProject.dart';
import 'BaseConstants.dart';
import 'inc/Reward.dart';
import 'package:http/http.dart' as http;

class ClaimReward extends StatefulWidget {
  final Reward rewardList;
  const ClaimReward({super.key, required this.rewardList});
  //const ClaimReward({Key? key}) : super(key: key);

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
          "Back to rewards",
          style: TextStyle(fontSize: 14.0),
        ),
        backgroundColor: Colors.lightGreen[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alert),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        // alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                widget.rewardList.name,
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 5,
              child: SizedBox.expand(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.network(
                    widget.rewardList.url,
                    fit: BoxFit.fill,
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
                      fontSize: 14.0,
                    ),
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
                      ElevatedButton(
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
                        // var parameters = "/{$uuid}/${widget.rewardList.uuid}";
                        // http.Response response = await http.get(Uri.parse(
                        //     BaseConstants.baseUrl +
                        //         BaseConstants.getInfoUrl +
                        //         parameters));
                        //
                        // if (response.statusCode == 200) {
                        //   var responseData = jsonDecode(response.body);
                        //
                        //   if (responseData["status"] == "success") {
                        //     var data = responseData["data"];
                        //     var prefs = await SharedPreferences.getInstance();
                        //     await prefs.setString('uuid', data["uuid"]);
                        //     await prefs.setString(
                        //         'user_name', data["username"]);
                        //     await prefs.setString(
                        //         'first_name', data["first_name"]);
                        //     await prefs.setString(
                        //         'last_name', data["last_name"]);
                        //     await prefs.setString('email', data["email"]);
                        //     await prefs.setString('mobile', data["mobile"]);
                        //     await prefs.setString('points', data["points"]);
                        //     await prefs.setString('address', data["address"]);
                        //     await prefs.setString(
                        //         'reward_img', data["img"]["dash_banner_1"]);
                        //     print(prefs.getString('uuid'));
                        //     Navigator.of(context).pushNamed(Dashboard.tag);
                        //   }
                        //   //return responseToParent[{"success": false, "message": responseData["type"] }];
                        // }
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
