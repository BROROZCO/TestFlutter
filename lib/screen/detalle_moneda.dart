import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/monedas_providers.dart';

class MonedaDetalle extends StatefulWidget {
  const MonedaDetalle({super.key});

  @override
  State<MonedaDetalle> createState() => _MonedaDetalle();
} // fin class

class _MonedaDetalle extends State<MonedaDetalle> {
  var coinModel = null;
  var convertCryptFromUSD2 = '';
  var convertCryptFromUSD1 = '';

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    coinModel = ModalRoute.of(context)!.settings.arguments;
    // ignore: non_constant_identifier_names
    final CryptoProviderService =
        Provider.of<CryptoProvider>(context, listen: false);
    var sym = coinModel.symbol;
    var name = coinModel.name;
    var idCryp = coinModel.id;
    String idCrypString = idCryp.toString();

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text('Detalle de la monedas'),
              ),
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                const Card(
                  elevation: 5,
                  borderOnForeground: true,
                  child: SizedBox(
                    width: 300,
                    height: 150,
                    child: Image(
                      image: NetworkImage(
                          'https://cryptologos.cc/logos/thumbs/0x.png'),
                    ),
                  ),
                ),
                ListTile(
                  // ignore: prefer_interpolation_to_compose_strings
                  title: Text("Sym: ${sym}"),
                ),
                ListTile(
                  // ignore: prefer_interpolation_to_compose_strings
                  title: Text("Name: ${name}"),
                ),
                FutureBuilder(
                    future: CryptoProviderService.getPrecioCrytp(idCryp),
                    builder: (_, AsyncSnapshot<double> snapshot) {
                      if (!snapshot.hasData) {
                        return const ListTile(
                          title: Text('Price-USD: 0'),
                        );
                      }

                      final val = snapshot.data!;

                      return Column(
                        children: [
                          ListTile(
                            title: Text("Price-USD: $val"),
                          ),
                          TextField(
                            decoration: InputDecoration(
                                labelText: 'De dolares a $idCrypString'),
                            keyboardType: TextInputType.number,
                            onSubmitted: (value) {
                              if (value.isEmpty) {
                                convertCryptFromUSD2 = (0 * val).toString();
                                setState(() {});
                              } else {
                                convertCryptFromUSD2 =
                                    (double.parse(value) * val).toString();

                                setState(() {});
                              }
                            },
                          ),
                          ListTile(
                            title:
                                Text('Precio por USD: $convertCryptFromUSD2'),
                          ),
                          TextField(
                            decoration: InputDecoration(
                                labelText: 'De $idCrypString a dolares'),
                            keyboardType: TextInputType.number,
                            onSubmitted: (value) {
                              if (value.isEmpty) {
                                convertCryptFromUSD1 = (0).toString();
                                setState(() {});
                              } else {
                                convertCryptFromUSD1 =
                                    (val / double.parse(value))
                                        .toStringAsFixed(2);

                                setState(() {});
                              }
                            },
                          ),
                          ListTile(
                            title: Text(
                                'Precio por $idCrypString: $convertCryptFromUSD1'),
                          )
                        ],
                      );
                    }),
              ],
            )));
  }
}

/*
0x.png
const Center(
              child: Card(
                elevation: 5,
                child: SizedBox(
                  width: 300,
                  height: 150,
                  child: Image(
                      image: NetworkImage(
                          'https://cryptologos.cc/logos/thumbs/0x.png')),
                ),
              ),

const Card(
              elevation: 10,
              child: SizedBox(
                width: 300,
                height: 100,
                child: Image(
                    image: NetworkImage(
                        'https://cryptologos.cc/logos/thumbs/0x.png')),
              ),
            ))


Column(
          children: const [

            Image(image: NetworkImage('https://cryptologos.cc/logos/thumbs/0x.png'))

          ],)

FutureBuilder(
        future: getImageAndPreciCoin(coinModel.name),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Text('Hola');
          }
        },
      ),

*/
