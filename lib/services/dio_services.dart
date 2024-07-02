import 'package:crypto_currencies_with_getx/const.dart';
import 'package:dio/dio.dart';

class DioServices {
  final Dio _dio = Dio();

  DioServices() {
    configDio();
  }
  configDio() {
    _dio.options = BaseOptions(baseUrl: baseUrl, queryParameters: {
      'api_key': apiKey,
    });
  }

  Future<dynamic> get(String path) async {
    try {
      Response response = await _dio.get(path);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
