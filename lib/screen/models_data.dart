// To parse this JSON data, do
//
//     final dataResultCoin = dataResultCoinFromJson(jsonString);

import 'dart:convert';

DataResultCoin dataResultCoinFromJson(String str) =>
    DataResultCoin.fromJson(json.decode(str));

String dataResultCoinToJson(DataResultCoin data) => json.encode(data.toJson());

class DataResultCoin {
  DataResultCoin({
    required this.result,
    required this.cursor,
    required this.allowance,
  });

  final List<Result> result;
  final Cursor cursor;
  final Allowance allowance;

  factory DataResultCoin.fromJson(Map<String, dynamic> json) => DataResultCoin(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        cursor: Cursor.fromJson(json["cursor"]),
        allowance: Allowance.fromJson(json["allowance"]),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "cursor": cursor.toJson(),
        "allowance": allowance.toJson(),
      };
}

class Allowance {
  Allowance({
    required this.cost,
    required this.remaining,
    required this.upgrade,
  });

  final double cost;
  final double remaining;
  final String upgrade;

  factory Allowance.fromJson(Map<String, dynamic> json) => Allowance(
        cost: json["cost"]?.toDouble(),
        remaining: json["remaining"]?.toDouble(),
        upgrade: json["upgrade"],
      );

  Map<String, dynamic> toJson() => {
        "cost": cost,
        "remaining": remaining,
        "upgrade": upgrade,
      };
}

class Cursor {
  Cursor({
    required this.last,
    required this.hasMore,
  });

  final String last;
  final bool hasMore;

  factory Cursor.fromJson(Map<String, dynamic> json) => Cursor(
        last: json["last"],
        hasMore: json["hasMore"],
      );

  Map<String, dynamic> toJson() => {
        "last": last,
        "hasMore": hasMore,
      };
}

class Result {
  Result({
    required this.id,
    required this.sid,
    required this.symbol,
    required this.name,
    required this.fiat,
    required this.route,
  });

  final int id;
  final String sid;
  final String symbol;
  final String name;
  final bool fiat;
  final String route;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        sid: json["sid"],
        symbol: json["symbol"],
        name: json["name"],
        fiat: json["fiat"],
        route: json["route"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sid": sid,
        "symbol": symbol,
        "name": name,
        "fiat": fiat,
        "route": route,
      };
}
