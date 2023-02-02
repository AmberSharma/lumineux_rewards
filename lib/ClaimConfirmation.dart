import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lumineux_rewards_app/BaseConstants.dart';
import 'package:http/http.dart' as http;
import 'package:lumineux_rewards_app/common/AppBarAction.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ActionSuccess.dart';

class ClaimConfirmation extends StatefulWidget {
  static String tag = "claim-confirmation";
  final String userUuid;
  final String itemUuid;
  final String userPoints;

  const ClaimConfirmation(
      {super.key,
      required this.userUuid,
      required this.itemUuid,
      required this.userPoints});

  @override
  State<ClaimConfirmation> createState() => _ClaimConfirmationState();
}

class _ClaimConfirmationState extends State<ClaimConfirmation> {
  int apiCall = 0;

  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff3C8A34),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: apiCall == 1
              ? const SpinKitRing(
                  color: Colors.white,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back_ios_new),
                          label: const Text(''),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        Column(
                          children: [
                            AppBarAction(parentTag: ClaimConfirmation.tag)
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
                                        .replaceAll(
                                            "{points}",
                                            myFormat.format(
                                                int.parse(widget.userPoints))),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    backgroundColor: const Color(0xffabcc59),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    minimumSize:
                                        const Size(150, 50), // Background color
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      apiCall = 1;
                                    });
                                    var parameters = "${widget.userUuid}/";
                                    var url = BaseConstants.baseUrl +
                                        BaseConstants.putClaimUrl +
                                        parameters;

                                    http.Response response =
                                        await http.post(Uri.parse(url), body: {
                                      'item_uuid': widget.itemUuid,
                                    });

                                    if (response.statusCode == 200) {
                                      var responseData =
                                          jsonDecode(response.body);
                                      setState(() {
                                        apiCall = 0;
                                      });

                                      if (responseData["status"] == "success") {
                                        var prefs = await SharedPreferences
                                            .getInstance();
                                        await prefs.setString('points',
                                            responseData["status_value"]);

                                        if (!mounted) return;
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ActionSuccess(
                                                    description: BaseConstants
                                                        .claimSubmitSuccess),
                                          ),
                                        );
                                      } else {
                                        throw Exception(
                                            responseData["status_msg"]);
                                      }
                                    }
                                  },
                                  child: const Text("Confirm"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
