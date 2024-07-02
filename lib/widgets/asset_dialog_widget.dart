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
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.8,
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
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return const Column(
        children: [],
      );
    }
  }
}

class AssetDialogController extends GetxController {
  RxBool loading = true.obs;
  @override
  void onInit() {
    super.onInit();

    Future.delayed(Durations.extralong4).then(
      (value) => loading.value = false,
    );
  }

}
