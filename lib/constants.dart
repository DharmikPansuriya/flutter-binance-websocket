import 'package:flutter/material.dart';

class AppColors {
  static const Color appBarColor = Color.fromARGB(255, 0, 53, 143);
  static const Color textColor = Colors.white;
  static const Color chipColor = Colors.blue;
  static const Color priceColor = Color.fromARGB(255, 250, 194, 25);
}

class AppTextStyles {
  static const TextStyle appBarTitle = TextStyle(
    color: AppColors.textColor,
    fontSize: 18,
  );

  static const TextStyle buttonText = TextStyle(
    color: AppColors.chipColor,
    fontSize: 16,
  );

  static const TextStyle chipText = TextStyle(
    fontSize: 12.0,
    color: AppColors.textColor,
  );

  static const TextStyle holdingText = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
    fontSize: 28,
  );

  static const TextStyle priceText = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.priceColor,
    fontSize: 28,
  );
}

const String masterWebSocketUrl = 'wss://stream.binance.com:9443/ws/{pair}@trade';

const List<String> holdings = [
  'btcusdt',
  'ethusdt',
  'bnbusdt',
  'xrpusdt',
  'ltcusdt'
];