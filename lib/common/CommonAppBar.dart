import 'package:flutter/material.dart';
import 'package:lumineux_rewards_app/NotificationView.dart';
import '../showCustomDialogPopup.dart';
import 'package:lumineux_rewards_app/AddReceiptProject.dart';

import 'AppBarAction.dart';
import 'LeadingAppBar.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CommonAppBar({Key? key}) : super(key: key);

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const LeadingAppBar(),
      backgroundColor: Colors.lightGreen[900],
      actions: const [AppBarAction()],
    );
  }
}
