import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/providers/monedas_providers.dart';
import 'screen/screen.dart';
import 'package:testapp/screen/detalle_moneda.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CryptoProvider(),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: const HomeScreenLazy(),
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => const HomeScreenLazy(),
        'detalleMoneda': (BuildContext context) => const MonedaDetalle(),
        'convertidorMoneda': (BuildContext context) => const ConvertidorMoneda()
      },
    );
  }
}
