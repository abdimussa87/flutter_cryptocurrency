import 'package:cryptocurrency_app/models/coin_model.dart';

abstract class BaseCryptoRepository{
  Future<List<Coin>> getTopCoins({int page});
  void dispose();

}