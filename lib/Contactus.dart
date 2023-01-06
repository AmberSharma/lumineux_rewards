import 'package:flutter/material.dart';

import 'BaseConstants.dart';
import 'CommonAppBar.dart';
import 'CommonBottomNavigationBar.dart';

class Contactus extends StatelessWidget {
  const Contactus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 22.0),
            child: Text(
              "Contact us",
              style: TextStyle(
                fontSize: 25.0,
              ),
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
                      BaseConstants.contactusDescription,
                      style: TextStyle(
                        fontSize: 16.0,
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
              children: [
                Padding(
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
                            text: 'Phone: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "+44 (0)1507 328 031"),
                      ],
                    ),
                  ),
                ),
                Padding(
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
                            text: 'Phone: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "+44 (0)1507 328 031"),
                      ],
                    ),
                  ),
                ),
                Padding(
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
                            text: 'Phone: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "+44 (0)1507 328 031"),
                      ],
                    ),
                  ),
                ),
                Padding(
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
                            text: 'Phone: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "+44 (0)1507 328 031"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
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
                            text: 'Phone: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "+44 (0)1507 328 031"),
                      ],
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
