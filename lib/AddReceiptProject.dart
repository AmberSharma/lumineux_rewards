import 'package:flutter/material.dart';
import 'package:lumineux_rewards_app/AddProject.dart';
import 'package:lumineux_rewards_app/AddReceipt.dart';

class AddReceiptProject extends StatelessWidget {
  const AddReceiptProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff3C8A34),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_left_sharp),
                    label: const Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add_alert),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: Column(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.receipt_long,
                            ),
                            iconSize: 100.0,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AddReceipt()),
                              );
                            },
                          ),
                          const Text(
                            "Add a receipt",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 10),
                      child: Column(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.handyman,
                            ),
                            iconSize: 100.0,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AddProject()),
                              );
                            },
                          ),
                          const Text(
                            "Add a project",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
