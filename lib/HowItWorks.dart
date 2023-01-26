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
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const Padding(
      //       padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
      //       child: Text(
      //         BaseConstants.howItWorksLabel,
      //         style: TextStyle(
      //           fontSize: 25.0,
      //         ),
      //       ),
      //     ),
      //     const Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 24.0),
      //       child: Text(
      //         BaseConstants.howItWorksDescription,
      //         style: TextStyle(
      //           fontSize: 17.0,
      //         ),
      //       ),
      //     ),
      //     Expanded(
      //       child: Row(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: const [
      //           Expanded(
      //             child: Padding(
      //               padding:
      //                   EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      //               child: Text.rich(
      //                 TextSpan(
      //                   // Note: Styles for TextSpans must be explicitly defined.
      //                   // Child text spans will inherit styles from parent
      //                   style: TextStyle(
      //                     fontSize: 17.0,
      //                   ),
      //                   children: <TextSpan>[
      //                     TextSpan(
      //                         text: "${BaseConstants.gainingPointsLabel}: ",
      //                         style: TextStyle(fontWeight: FontWeight.bold)),
      //                     TextSpan(
      //                         text: BaseConstants.gainingPointsDescription),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //     Expanded(
      //       child: Row(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: const [
      //           Expanded(
      //             child: Padding(
      //               padding:
      //                   EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      //               child: Text.rich(
      //                 TextSpan(
      //                   // Note: Styles for TextSpans must be explicitly defined.
      //                   // Child text spans will inherit styles from parent
      //                   style: TextStyle(
      //                     fontSize: 17.0,
      //                   ),
      //                   children: <TextSpan>[
      //                     TextSpan(
      //                         text: "${BaseConstants.addingReceiptLabel}: ",
      //                         style: TextStyle(fontWeight: FontWeight.bold)),
      //                     TextSpan(
      //                         text: BaseConstants.addingReceiptDescription),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //     Expanded(
      //       child: Row(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: const [
      //           Expanded(
      //             child: Padding(
      //               padding:
      //                   EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      //               child: Text.rich(
      //                 TextSpan(
      //                   // Note: Styles for TextSpans must be explicitly defined.
      //                   // Child text spans will inherit styles from parent
      //                   style: TextStyle(
      //                     fontSize: 17.0,
      //                   ),
      //                   children: <TextSpan>[
      //                     TextSpan(
      //                         text: "${BaseConstants.addingProjectLabel}: ",
      //                         style: TextStyle(fontWeight: FontWeight.bold)),
      //                     TextSpan(
      //                         text: BaseConstants.addingProjectDescription1),
      //                     TextSpan(
      //                         text: BaseConstants.addingProjectDescription2),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //     Expanded(
      //       child: Row(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: const [
      //           Expanded(
      //             child: Padding(
      //               padding:
      //                   EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      //               child: Text.rich(
      //                 TextSpan(
      //                   // Note: Styles for TextSpans must be explicitly defined.
      //                   // Child text spans will inherit styles from parent
      //                   style: TextStyle(
      //                     fontSize: 17.0,
      //                   ),
      //                   children: <TextSpan>[
      //                     TextSpan(
      //                         text: "${BaseConstants.gainingPointsLabel}: ",
      //                         style: TextStyle(fontWeight: FontWeight.bold)),
      //                     TextSpan(
      //                         text: BaseConstants.gainingPointsDescription),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      body: RawScrollbar(
        thumbColor: Colors.green,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Wrap(
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                child: Text(
                  BaseConstants.howItWorksLabel,
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                child: Text(
                  BaseConstants.howItWorksDescription,
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                child: Text.rich(
                  TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: "${BaseConstants.gainingPointsLabel}: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: BaseConstants.gainingPointsDescription),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                child: Text.rich(
                  TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: "${BaseConstants.addingReceiptLabel}: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: BaseConstants.addingReceiptDescription),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                child: Text.rich(
                  TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: "${BaseConstants.addingProjectLabel}: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: BaseConstants.addingProjectDescription1),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                child: Text(
                  BaseConstants.addingProjectDescription2,
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                child: Text.rich(
                  TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: "${BaseConstants.browsingRewardsLabel}: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: BaseConstants.browsingRewardsDescription),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                child: Text.rich(
                  TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: "${BaseConstants.claimingRewardsLabel}: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: BaseConstants.claimingRewardsDescription),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CommonBottomNavigationBar(),
    );
  }
}
