import 'package:flutter/material.dart';

import '../NotificationView.dart';

class AppBarAction extends StatefulWidget {
  const AppBarAction({Key? key}) : super(key: key);

  @override
  State<AppBarAction> createState() => _AppBarActionState();
}

class _AppBarActionState extends State<AppBarAction> {
  int notificationCounter = 6;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IconButton(
        icon: const Icon(
          Icons.notifications,
          size: 30.0,
        ),
        onPressed: () {
          setState(() {
            notificationCounter = 0;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationView()),
          );
        },
      ),
      notificationCounter != 0
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
                  '$notificationCounter',
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
}
