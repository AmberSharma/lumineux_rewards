import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lumineux_rewards_app/AddProject.dart';
import 'package:lumineux_rewards_app/AddReceipt.dart';
import 'package:lumineux_rewards_app/BaseConstants.dart';
import 'package:http/http.dart' as http;

import 'ActionSuccess.dart';

class ClaimConfirmation extends StatelessWidget {
  final String userUuid;
  final String itemUuid;
  final String userPoints;

  const ClaimConfirmation(
      {super.key,
      required this.userUuid,
      required this.itemUuid,
      required this.userPoints});

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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                            child: Text(
                              (BaseConstants.claimConfirmationDescription)
                                  .replaceAll("{points}", userPoints),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                              backgroundColor: const Color(0xFFABCC59),
                            ),
                            onPressed: () async {
                              final queryParameters = {
                                'item_uuid': itemUuid,
                              };

                              var parameters = "$userUuid/";
                              http.Response response = await http.put(
                                  Uri.parse(
                                    BaseConstants.baseUrl +
                                        BaseConstants.putClaimUrl +
                                        parameters,
                                  ),
                                  headers: <String, String>{
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                  },
                                  body: jsonEncode(queryParameters));

                              print(response);
                              if (response.statusCode == 200) {
                                var responseData = jsonDecode(response.body);
                                print(responseData);
                                if (responseData["status"] == "success") {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ActionSuccess(
                                          description:
                                              BaseConstants.claimSubmitSuccess),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text("Confirm"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 5, right: 10),
                  //     child: Column(
                  //       children: [
                  //         IconButton(
                  //           icon: const Icon(
                  //             Icons.handyman,
                  //           ),
                  //           iconSize: 100.0,
                  //           color: Colors.white,
                  //           onPressed: () {
                  //             Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => const AddProject()),
                  //             );
                  //           },
                  //         ),
                  //         const Text(
                  //           "Add a project",
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
