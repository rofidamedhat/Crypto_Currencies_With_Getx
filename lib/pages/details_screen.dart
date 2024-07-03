import 'package:crypto_currencies_with_getx/models/coin_data.dart';
import 'package:crypto_currencies_with_getx/utils.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final CoinData coinData;
  DetailsPage({
    Key? key,
    required this.coinData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _buildUI(context),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(coinData.name!),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.02,
        ),
        child: Column(
          children: [
            _getAssetPrice(context),
            _assetInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _getAssetPrice(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.09,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.network(
              getAssetImage(
                coinData.name!,
              ),
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      "\$ ${coinData.values?.uSD?.price?.toStringAsFixed(2)}\n",
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
                TextSpan(
                  text:
                      "${coinData.values?.uSD?.percentChange24h?.toStringAsFixed(2)} %",
                  style: TextStyle(
                    fontSize: 15,
                    color: coinData.values!.uSD!.percentChange24h! > 0
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _assetInfo(BuildContext context) {
    return Expanded(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
        ),
        children: [
          _cardInfo(
            "Circulating Supply",
            coinData.circulatingSupply.toString(),
          ),
          _cardInfo(
            "Maximum Supply",
            coinData.maxSupply.toString(),
          ),
          _cardInfo(
            "Total Supply",
            coinData.totalSupply.toString(),
          ),
        ],
      ),
    );
  }

  Widget _cardInfo(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
