import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/crypto_coins.dart';
import '../search/search_delegate.dart';
import 'detalle_moneda.dart';
import 'models_data.dart';

class HomeScreenLazy extends StatefulWidget {
  const HomeScreenLazy({super.key});

  @override
  State<HomeScreenLazy> createState() => _HomeScreenLazyState();
} // fin class

class _HomeScreenLazyState extends State<HomeScreenLazy> {
  @override
  void initState() {
    super.initState();
    getTypeCoins();
  }

  //List<NewResultCoins> values = [];

  List<CryptoCoins> coins = [];

  Future<void> getTypeCoins() async {
    final dio = Dio();
    // https://api.coingecko.com/api/v3/coins/list
    //final response = await dio.get('https://api.cryptowat.ch/assets');

    // Moneda

    final listCoins =
        await dio.get('https://api.coingecko.com/api/v3/coins/list');

    listCoins;

    for (var element in listCoins.data) {
      var _id = element['id'];
      var _symbol = element['symbol'];
      var _name = element['name'];

      CryptoCoins valueAuxiliar =
          CryptoCoins(id: _id, symbol: _symbol, name: _name);
      coins.add(valueAuxiliar);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Lista de monedas'),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () =>
                  showSearch(context: context, delegate: CryptoCoinsSearch()))
        ],
      ),
      body: ListView.separated(
          itemCount: coins.length,
          itemBuilder: (context, index) => ListTile(
                title: Text(coins[index].name),
                trailing: const Icon(Icons.arrow_forward_outlined),
                onTap: () {
                  final coinModel = coins[index];

                  Navigator.pushNamed(context, 'detalleMoneda',
                      arguments: coinModel);
                },
              ),
          separatorBuilder: (_, __) => const Divider()),
    );
  }
}
