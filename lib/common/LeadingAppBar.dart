import 'package:flutter/material.dart';
import 'package:lumineux_rewards_app/Dashboard.dart';

import '../AddReceiptProject.dart';
import '../showCustomDialogPopup.dart';

class LeadingAppBar extends StatelessWidget {
  const LeadingAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.home_filled),
          // onPressed: () async {
          //   await showCustomDialogPopup<String?>(
          //       context, const AddReceiptProject());
          // },
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Dashboard(),
              ),
            );
          },
        );
      },
    );
  }
}
