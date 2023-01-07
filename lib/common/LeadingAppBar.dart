import 'package:flutter/material.dart';

import '../AddReceiptProject.dart';
import '../showCustomDialogPopup.dart';

class LeadingAppBar extends StatelessWidget {
  const LeadingAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.add_circle),
          onPressed: () async {
            await showCustomDialogPopup<String?>(
                context, const AddReceiptProject());
          },
        );
      },
    );
  }
}
