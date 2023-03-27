import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ConvertidorMoneda());

class ConvertidorMoneda extends StatelessWidget {
  const ConvertidorMoneda({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
      body: Text('Convertidor Moneda'),
    ));
  }
}
