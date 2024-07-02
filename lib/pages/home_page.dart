import 'package:crypto_currencies_with_getx/widgets/asset_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: const CircleAvatar(
        backgroundImage: NetworkImage(
          'https://icons.veryicon.com/png/o/miscellaneous/bitisland-world/person-18.png',
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.dialog(AssetDialogWidget());
          },
          icon: const Icon(
            Icons.add,
          ),
        ),
      ],
    );
  }
}
