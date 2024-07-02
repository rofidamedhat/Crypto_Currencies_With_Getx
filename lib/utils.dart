import 'package:crypto_currencies_with_getx/services/dio_services.dart';
import 'package:get/get.dart';

registerDio() async {
  Get.put(DioServices());
}
