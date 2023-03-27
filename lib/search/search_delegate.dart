import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/providers/monedas_providers.dart';

import '../models/crypto_coins.dart';

class CryptoCoinsSearch extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar moneda';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => {
          query = '',
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Icon(
          Icons.list_alt_outlined,
          color: Colors.black38,
          size: 100,
        ),
      );
    }

    final listCrypto = Provider.of<CryptoProvider>(context, listen: false);

    return FutureBuilder(
      future: listCrypto.filterList(query),
      builder: (_, AsyncSnapshot<List<CryptoCoins>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Icon(
              Icons.list_alt_outlined,
              color: Colors.black38,
              size: 100,
            ),
          );
        }

        final crypt = snapshot.data!;

        return ListView.builder(
          itemCount: crypt.length,
          itemBuilder: (_, int index) => _SugerenciaCoins(crypt[index]),
        );
      },
    );
  }
}

class _SugerenciaCoins extends StatelessWidget {
  final CryptoCoins selectCoins;

  const _SugerenciaCoins(this.selectCoins);

  @override
  Widget build(BuildContext context) {
    //CryptoCoins item = new CryptoCoins(id: this.selectCoins.id, symbol: this.selectCoins.symbol, name: this.selectCoins.name)
    String name = selectCoins.name;
    return ListTile(
      title: Text(name),
      trailing: const Icon(Icons.arrow_forward_outlined),
      onTap: () {
        Navigator.pushNamed(context, 'detalleMoneda', arguments: selectCoins);
      },
    );
  }
}
