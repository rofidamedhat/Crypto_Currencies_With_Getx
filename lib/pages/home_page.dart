
import 'package:crypto_currencies_with_getx/controller/asset_controller.dart';
import 'package:crypto_currencies_with_getx/pages/details_screen.dart';
import 'package:crypto_currencies_with_getx/utils.dart';
import 'package:crypto_currencies_with_getx/widgets/asset_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  AssetController assetController = Get.find<AssetController>();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _appBar(context),
      body: _buildUI(context),
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

  Widget _buildUI(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Center(
          child: Column(
            children: [
              _getPortofolioValue(context),
              _getAssetsList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPortofolioValue(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * .02,
      ),
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: '\$  ',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: assetController.getPortofolioValue().toStringAsFixed(2),
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * .045,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const TextSpan(
                text: '\n Portoflio Value',
                style: TextStyle(
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getAssetsList(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: assetController.trackedassets.length,
        itemBuilder: (context, index) {
          final trackedAsset = assetController.trackedassets[index];
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            margin: const EdgeInsets.all(5),
            child: ListTile(
              onTap: () {
                Get.to(
                  () => DetailsPage(
                    coinData: assetController.getCoinName(trackedAsset.name!)!,
                  ),
                );
              },
              leading: Image.network(getAssetImage(trackedAsset.name!)),
              title: Text(trackedAsset.name!),
              subtitle: Text(
                  'USD :  ${assetController.getPortofolioValue().toStringAsFixed(2).toString()}'),
              trailing: Text(
                trackedAsset.amount.toString(),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
