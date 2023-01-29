import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lumineux_rewards_app/ClaimReward.dart';
import 'package:lumineux_rewards_app/NotificationView.dart';
import 'package:lumineux_rewards_app/common/AppBarAction.dart';
import 'package:lumineux_rewards_app/common/CommonAppBar.dart';
import 'package:lumineux_rewards_app/common/CommonBottomNavigationBar.dart';
import 'package:lumineux_rewards_app/common/LeadingAppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BaseConstants.dart';
import 'inc/NotificationData.dart';
import 'inc/Reward.dart';
import 'package:http/http.dart' as http;

class NotificationDetail extends StatefulWidget {
  static String tag = "notification-detail";
  final NotificationData notificationList;
  const NotificationDetail({super.key, required this.notificationList});

  @override
  State<StatefulWidget> createState() {
    return NotificationDetailView();
  }
}

class NotificationDetailView extends State<NotificationDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    markNotificationAsRead();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationView()))),
        // title: const Text(
        //   "Back to alerts",
        //   style: TextStyle(fontSize: 14.0),
        // ),
        backgroundColor: const Color(0xff338c2e),
        actions: [
          AppBarAction(
            parentTag: NotificationDetail.tag,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Wrap(
          //crossAxisAlignment: CrossAxisAlignment.start,
          runSpacing: 20.0,
          children: [
            Text(
              widget.notificationList.name,
              style: const TextStyle(fontSize: 30.0),
            ),
            Text(
              widget.notificationList.description,
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              widget.notificationList.date,
              style: const TextStyle(fontSize: 15.0),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CommonBottomNavigationBar(),
    );
  }

  void markNotificationAsRead() async {
    if (int.parse(widget.notificationList.read) == 0) {
      var prefs = await SharedPreferences.getInstance();
      var uuid = prefs.getString(BaseConstants.uuid)!;
      var url =
          "${BaseConstants.baseUrl}${BaseConstants.updateNotificationUrl}$uuid/";
      http.Response response = await http.post(Uri.parse(url),
          body: {"notification_uuid": widget.notificationList.uuid});
      // print(url);
      // print(widget.notificationList.uuid);
      // if (response.statusCode == 200) {
      //   var responseData = jsonDecode(response.body);
      //   print(responseData);
      // }
    }
  }
}
