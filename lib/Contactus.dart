import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'BaseConstants.dart';
import 'common/CommonAppBar.dart';
import 'common/CommonBottomNavigationBar.dart';

class Contactus extends StatelessWidget {
  static String tag = "contactus";
  const Contactus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        parentTag: Contactus.tag,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 22.0),
            child: Text(
              BaseConstants.contactUsPageLabel,
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
          ),
          Row(
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
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 48.0, 0.0, 0.0),
                    child: RichText(
                      text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: const TextStyle(
                            fontSize: 17.0,
                            color: Colors.black,
                            fontFamily: 'Montserrat'),
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'Phone: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: BaseConstants.phoneNumberLabel,
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final url = Uri.parse(
                                    "tel:${BaseConstants.phoneNumberLabel}");
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                }
                              },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: RichText(
                      text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: const TextStyle(
                            fontSize: 17.0,
                            color: Colors.black,
                            fontFamily: 'Montserrat'),
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'Email: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: BaseConstants.emailLabel,
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                //const toEmail = BaseConstants.emailLabel;
                                final Uri url = Uri(
                                  scheme: 'mailto',
                                  path: BaseConstants.emailLabel,
                                );
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                }
                              },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 0.0, 0.0, 0.0),
                    child: RichText(
                      text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: const TextStyle(
                            fontSize: 17.0,
                            color: Colors.black,
                            fontFamily: 'Montserrat'),
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'Web: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: BaseConstants.websiteLabel,
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final url = Uri.parse(
                                    "https://${BaseConstants.websiteLabel}");
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                }
                              },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        RichText(
                          text: const TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.black,
                                fontFamily: 'Montserrat'),
                            children: [
                              TextSpan(
                                  text: 'Socials: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: GestureDetector(
                            onTap: () async {
                              final url =
                                  Uri.parse(BaseConstants.facebookLabel);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              }
                            },
                            child: const Icon(
                              FontAwesomeIcons.facebookF,
                              size: 18.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: GestureDetector(
                            onTap: () async {
                              final url = Uri.parse(BaseConstants.twitterLabel);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              }
                            },
                            child: const Icon(
                              FontAwesomeIcons.twitter,
                              size: 18.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: GestureDetector(
                            onTap: () async {
                              final url =
                                  Uri.parse(BaseConstants.linkedinLabel);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              }
                            },
                            child: const Icon(
                              FontAwesomeIcons.linkedinIn,
                              size: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
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
                            text: 'Address: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                "Lumineux,Manby Business Park, Manby, Lincolnshire, LN11 8UT"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Policies: ",
                  style: TextStyle(fontSize: 17.0),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(BaseConstants.privacyPolicyLink);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                    child: const Text(
                      BaseConstants.privacyPolicyLabel,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final url = Uri.parse(BaseConstants.termsOfUseLink);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  child: const Text(
                    BaseConstants.termsOfUseLabel,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue),
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
