import 'package:flutter/material.dart';
import 'showCustomDialogPopup.dart';
import 'package:lumineux_rewards_app/AddReceiptProject.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () async {
              await showCustomDialogPopup<String?>(
                  context, const AddReceiptProject());
            },
          );
        },
      ),
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
