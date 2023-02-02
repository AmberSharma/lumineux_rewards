import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lumineux_rewards_app/NotificationDetail.dart';
import 'package:lumineux_rewards_app/common/CommonAppBar.dart';
import 'package:lumineux_rewards_app/common/CommonBottomNavigationBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BaseConstants.dart';
import 'inc/NotificationData.dart';
import 'package:http/http.dart' as http;

class NotificationView extends StatefulWidget {
  static String tag = "notification-view";
  const NotificationView({super.key});

  @override
  State<StatefulWidget> createState() {
    return NotificationListView();
  }
}

class NotificationListView extends State<NotificationView> {
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  List<NotificationData> notificationList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotificationList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        parentTag: NotificationView.tag,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Alerts",
                  style: TextStyle(fontSize: 22.0),
                ),
                // ElevatedButton(
                //   onPressed: () {},
                //   style: ElevatedButton.styleFrom(
                //     shape: const StadiumBorder(),
                //     backgroundColor: const Color(0xFFABCC59),
                //   ),
                //   child: const Text('Mark all as read'),
                // )
              ],
            ),
          ),
          Expanded(
              child: notificationList.isEmpty
                  ? const SpinKitRing(
                      color: Colors.green,
                    )
                  : buildNotifications(notificationList)),
        ],
      ),
      bottomNavigationBar: const CommonBottomNavigationBar(),
    );
  }

  Widget buildNotifications(List<NotificationData> notifications) =>
      ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Hero(
                tag: notification.uuid,
                // Wrap the ListTile in a Material widget so the ListTile has someplace
                // to draw the animated colors during the hero transition.
                child: Material(
                  child: Card(
                    child: ListTile(
                      title: Text(
                        notification.name,
                        style: TextStyle(
                            fontWeight: notification.read == "1"
                                ? FontWeight.normal
                                : FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notification.description),
                          Text(notification.date)
                        ],
                      ),
                      tileColor: Colors.white,
                      onTap: () {
                        NotificationData argument = NotificationData(
                            name: notification.name,
                            uuid: notification.uuid,
                            date: notification.date,
                            read: notification.read,
                            description: notification.description);
                        Navigator.push(
                          context,
                          MaterialPageRoute<Widget>(
                              builder: (BuildContext context) =>
                                  NotificationDetail(
                                    notificationList: argument,
                                  )
                              // return Scaffold(
                              //   appBar:
                              //       AppBar(title: const Text('ListTile Hero')),
                              //   body: Center(
                              //     child: Hero(
                              //       tag: notification.uuid,
                              //       child: Material(
                              //         child: ListTile(
                              //           title: Text(notification.name),
                              //           subtitle: Text(notification.description),
                              //           tileColor: Colors.blue[700],
                              //           onTap: () {
                              //             Navigator.pop(context);
                              //           },
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // );
                              // }
                              ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );

  void getNotificationList() async {
    var prefs = await SharedPreferences.getInstance();
    var uuid = prefs.getString(BaseConstants.uuid)!;
    var url = BaseConstants.baseUrl + BaseConstants.getNotificationUrl + uuid;
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData["status"] == "success") {
        List data = responseData["data"];
        List notificationJson = [];
        for (var item in data) {
          notificationJson.add({
            "uuid": item["uuid"],
            "name": item["title"],
            "date": item["date_added"],
            "description": item["content"],
            "read": item["read"]
          });
        }
        var notificationListDummy = notificationJson
            .map<NotificationData>(NotificationData.fromJson)
            .toList();
        setState(() {
          notificationList = notificationListDummy;
        });
      }
    }
  }
}
