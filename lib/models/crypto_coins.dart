import 'dart:convert';

List<CryptoCoins> cryptoCoinsFromJson(String str) => List<CryptoCoins>.from(
    json.decode(str).map((x) => CryptoCoins.fromJson(x)));

String cryptoCoinsToJson(List<CryptoCoins> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CryptoCoins {
  CryptoCoins({
    required this.id,
    required this.symbol,
    required this.name,
  });

  late final String id;
  late final String symbol;
  late final String name;

  factory CryptoCoins.fromJson(Map<String, dynamic> json) => CryptoCoins(
        id: json["id"],
        symbol: json["symbol"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "symbol": symbol,
        "name": name,
      };
}
