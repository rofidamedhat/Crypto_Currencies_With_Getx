import 'package:crypto_currencies_with_getx/controller/asset_controller.dart';
import 'package:crypto_currencies_with_getx/models/api_response.dart';
import 'package:crypto_currencies_with_getx/services/dio_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssetDialogWidget extends StatelessWidget {
  final AssetDialogController controller = Get.put(AssetDialogController());
  AssetDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Material(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.white),
            child: _buildUI(context),
          ),
        ),
      ),
    );
  }

  Widget _buildUI(BuildContext context) {
    if (controller.loading.isTrue) {
      return const Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButton(
              value: controller.selectedAsset.value,
              items: controller.assets.map((asset) {
                return DropdownMenuItem(
                  value: asset,
                  child: Text(asset),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  controller.selectedAsset.value = val;
                }
              },
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      15,
                    ),
                  ),
                ),
              ),
              onChanged: (value) {
                controller.assertValue.value = double.parse(value);
                print(value);
              },
            ),
            MaterialButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                AssetController assetController = Get.find();
                assetController.addTrackedAssets(
                  controller.selectedAsset.value,
                  controller.assertValue.value,
                );
                Get.back(
                  closeOverlays: true,
                );
              },
              child: const Text('Add Asset'),
            ),
          ],
        ),
      );
    }
  }
}

class AssetDialogController extends GetxController {
  RxBool loading = false.obs;
  RxList<String> assets = <String>[].obs;
  RxString selectedAsset = ''.obs;
  RxDouble assertValue = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    getAssets();
  }

  getAssets() async {
    loading.value = true;
    DioServices dioServices = Get.find();
    final responseData = await dioServices.get('currencies');
    CurrenciesListAPIResponse currenciesListAPIResponse =
        CurrenciesListAPIResponse.fromJson(responseData);
    currenciesListAPIResponse.data?.forEach((asset) {
      assets.add(asset.name!);
    });
    selectedAsset.value = assets.first;
    loading.value = false;
  }
}
