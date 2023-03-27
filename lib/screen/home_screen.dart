import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'models_data.dart';
//import 'models_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
} // fin class

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getTypeCoins();
  }

  DataResultCoin? values;

  var coins = [];

  Future<void> getTypeCoins() async {
    final dio = Dio();
    final response = await dio.get('https://api.cryptowat.ch/assets');

    values = DataResultCoin.fromJson(response.data);
    coins.addAll(values!.result);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Lista de monedas'),
          ),
        ),
        body: ListView(
          children: [
            ...coins
                .map((moneda) => ListTile(
                      title: Text(moneda.name),
                      trailing: const Icon(Icons.arrow_forward_outlined),
                    ))
                .toList()
          ],
        ));
  }
}

/*
  const HomeScreen({super.key});
  final _baseUrl = 'api.cryptowat.ch';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Home'),
          ),
        ),
        body: ListView(
          children: const [Text('Hola')],
        ));
  }

  // https://api.cryptowat.ch/assets
  void listCoinFn() async {
    //var url = Uri.https(_baseUrl, 'assets');
    //var resp = await http.get(url);

    //print(resp.body);
  }


*/