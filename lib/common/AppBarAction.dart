import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../BaseConstants.dart';
import '../NotificationView.dart';
import 'package:http/http.dart' as http;

class AppBarAction extends StatefulWidget {
  final String parentTag;
  static int notificationCounter = 0;
  const AppBarAction({super.key, required this.parentTag});

  @override
  State<AppBarAction> createState() => _AppBarActionState();
}

class _AppBarActionState extends State<AppBarAction> {
  @override
  void initState() {
    super.initState();
    fetchNotificationCount();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IconButton(
        icon: const Icon(
          Icons.notifications,
          size: 30.0,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationView()),
          );
        },
      ),
      AppBarAction.notificationCounter != 0
          ? Positioned(
              right: 26,
              top: 12,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: const BoxConstraints(
                  minWidth: 14,
                  minHeight: 14,
                ),
                child: Text(
                  AppBarAction.notificationCounter.toString(),
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 8,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : Container()
    ]);
  }

  void fetchNotificationCount() async {
    var viewList = ["dashboard", "notification-detail"];
    if (viewList.contains(widget.parentTag)) {
      var prefs = await SharedPreferences.getInstance();
      var uuid = prefs.getString(BaseConstants.uuid)!;
      var url = BaseConstants.baseUrl + BaseConstants.getNotificationUrl + uuid;
      http.Response response = await http.get(Uri.parse(url));
      AppBarAction.notificationCounter = 0;

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData["status"] == "success") {
          List data = responseData["data"];
          for (var item in data) {
            if (int.parse(item["read"]) == 0) {
              setState(() {
                AppBarAction.notificationCounter++;
              });
            }
          }
        }
      }
    }
  }
}
