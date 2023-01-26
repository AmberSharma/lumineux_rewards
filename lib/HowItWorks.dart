import 'package:flutter/material.dart';

import 'BaseConstants.dart';
import 'common/CommonAppBar.dart';
import 'common/CommonBottomNavigationBar.dart';

class HowItWorks extends StatelessWidget {
  static String tag = "how-it-works";
  const HowItWorks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        parentTag: HowItWorks.tag,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 22.0),
            child: Text(
              "How it Works",
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: RichText(
                      text: const TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.black,
                            fontFamily: 'Montserrat'),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Gaining points: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: BaseConstants.addReceiptDescription),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      BaseConstants.addReceiptDescription,
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      BaseConstants.addReceiptDescription,
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CommonBottomNavigationBar(),
    );
  }
}
