import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/crypto_coins.dart';

class CryptoProvider extends ChangeNotifier {
  CryptoProvider() {
    //getListCrypto();
  }

  List<CryptoCoins> coins = [];

  getListCrypto() async {
    final dio = Dio();
    final listCoins =
        await dio.get('https://api.coingecko.com/api/v3/coins/list');

    for (var element in listCoins.data) {
      var _id = element['id'];
      var _symbol = element['symbol'];
      var _name = element['name'];

      CryptoCoins valueAuxiliar =
          CryptoCoins(id: _id, symbol: _symbol, name: _name);
      coins.add(valueAuxiliar);
    }
  }

  Future<List<CryptoCoins>> filterList(String query) async {
    List<CryptoCoins> _coins = [];

    final dio = Dio();
    final listCoins =
        await dio.get('https://api.coingecko.com/api/v3/coins/list');

    for (var element in listCoins.data) {
      var _id = element['id'];
      var _symbol = element['symbol'];
      var _name = element['name'];

      CryptoCoins valueAuxiliar =
          CryptoCoins(id: _id, symbol: _symbol, name: _name);
      _coins.add(valueAuxiliar);
    }

    _coins.retainWhere((element) {
      return element.name.toLowerCase().contains(query.toLowerCase());
    });

    return _coins;
  }

  Future<double> getPrecioCrytp(String nameMoneda) async {
    final dio = Dio();
    final obj = await dio.get(
        'https://api.coingecko.com/api/v3/simple/price?ids=$nameMoneda&vs_currencies=usd');

    var resp = obj.data;
    var x = resp[nameMoneda];
    var val = x['usd'];
    return val;
  }
}
