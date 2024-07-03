import 'package:crypto_currencies_with_getx/controller/asset_controller.dart';
import 'package:crypto_currencies_with_getx/services/dio_services.dart';
import 'package:get/get.dart';

registerDio() async {
  Get.put(DioServices());
}

registerAssetController() async {
  Get.put(AssetController());
}

getAssetImage(String name) {
  return "https://raw.githubusercontent.com/ErikThiart/cryptocurrency-icons/master/128/${name.toLowerCase()}.png";
}
