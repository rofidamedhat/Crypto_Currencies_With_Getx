import 'package:crypto_currencies_with_getx/models/api_response.dart';
import 'package:crypto_currencies_with_getx/models/coin_data.dart';
import 'package:crypto_currencies_with_getx/models/tracked_asset.dart';
import 'package:crypto_currencies_with_getx/services/dio_services.dart';
import 'package:get/get.dart';

class AssetController extends GetxController {
  RxBool loading = false.obs;
  RxList<TrackedAsset> trackedassets = <TrackedAsset>[].obs;
  RxList<CoinData> coinList = <CoinData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAssets();
  }

  getAssets() async {
    loading.value = true;
    DioServices dioServices = Get.find();
    var responseData = await dioServices.get('currencies');
    CurrenciesListAPIResponse currenciesListAPIResponse =
        CurrenciesListAPIResponse.fromJson(responseData);
    coinList.value = currenciesListAPIResponse.data ?? [];
    loading.value = false;
  }

  addTrackedAssets(String name, double amount) {
    trackedassets.add(TrackedAsset(name: name, amount: amount));
    return trackedassets;
  }

  double getPortofolioValue() {
    if(trackedassets.isEmpty){
      return 0;
    }
    if(coinList.isEmpty){
      return 0 ;
    }
    double value = 0.0;
    for (TrackedAsset asset in trackedassets) {
      value += getCoinPrice(asset.name!) * asset.amount!;
    }
    return value;
  }

  CoinData? getCoinName(String name) {
    return coinList.firstWhereOrNull((coin) => coin.name == name);
  }

  double getCoinPrice(String name) {
    return getCoinName(name)?.values?.uSD?.price?.toDouble() ?? 0;
  }
}
