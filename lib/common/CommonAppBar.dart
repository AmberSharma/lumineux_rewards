import 'package:flutter/material.dart';
import '../showCustomDialogPopup.dart';
import 'package:lumineux_rewards_app/AddReceiptProject.dart';

import 'LeadingAppBar.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const LeadingAppBar(),
      backgroundColor: Colors.lightGreen[900],
      actions: [
        IconButton(
          icon: const Icon(Icons.add_alert),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
