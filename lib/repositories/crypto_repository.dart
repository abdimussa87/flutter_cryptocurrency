import 'dart:convert';

import 'package:cryptocurrency_app/models/coin_model.dart';
import 'package:cryptocurrency_app/repositories/base_crypto_repository.dart';
import 'package:http/http.dart' as http;

class CryptoRepository extends BaseCryptoRepository {
  static const String _baseUrl = "https://min-api.cryptocompare.com";
  static const int _perApiCall = 20;
  final http.Client _httpClient;

  CryptoRepository(http.Client httpClient)
      : _httpClient = httpClient ?? http.Client();
  @override
  Future<List<Coin>> getTopCoins({int page}) async {
    List<Coin> coins = [];

    String requestUrl =
        "$_baseUrl/data/top/totalvolfull?limit=$_perApiCall&tsym=USD&page=$page";
    try {
      final response = await _httpClient.get(requestUrl);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> coinList = data['Data'];
        coinList.forEach(
          (coinAsJson) => coins.add(Coin.fromJson(coinAsJson)),
        );
      }
      return coins;
    } catch (err) {
      throw (err);
    }
  }

  @override
  void dispose() {
    _httpClient.close();
  }
}
