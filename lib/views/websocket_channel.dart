import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../constants.dart'; // Import the constants file
import '../services/websocket_service.dart'; // Import the WebSocket service

class WebsocketChannel extends StatefulWidget {
  const WebsocketChannel({super.key});

  @override
  State<WebsocketChannel> createState() => _WebsocketChannelState();
}

class _WebsocketChannelState extends State<WebsocketChannel> {
  List<String> selectedHoldings = [];
  Map<String, String> prices = {};
  late WebSocketService webSocketService;

  @override
  void initState() {
    super.initState();
    // Initialize WebSocketService with the master URL from environment variables or constants
    webSocketService = WebSocketService(dotenv.env['MASTER_WEBSOCKET_URL'] ?? masterWebSocketUrl);
  }

  void addStreamListener(String holding) {
    // Ensure proper callback is used for WebSocket updates
    webSocketService.addListener(holding, (price) {
      setState(() {
        prices[holding] = price;
      });
    });
  }

  @override
  void dispose() {
    // Ensure WebSocket service is properly disposed
    webSocketService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Live Crypto Tracker - USDT Pairs',
          style: AppTextStyles.appBarTitle,
        ),
        backgroundColor: AppColors.appBarColor,
      ),
      backgroundColor: AppColors.appBarColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
              child: MultiSelectDialogField(
                items: holdings
                    .map((holding) =>
                        MultiSelectItem<String>(holding, holding.toUpperCase()))
                    .toList(),
                title: const Text("Select Holdings"),
                selectedColor: AppColors.chipColor,
                decoration: BoxDecoration(
                  color: AppColors.chipColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  border: Border.all(
                    color: AppColors.chipColor,
                    width: 2,
                  ),
                ),
                buttonIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.chipColor,
                ),
                buttonText: const Text(
                  "Select Holdings",
                  style: AppTextStyles.buttonText,
                ),
                onConfirm: (results) {
                  setState(() {
                    selectedHoldings = List<String>.from(results);
                    // Add a stream listener for each selected holding
                    for (var holding in selectedHoldings) {
                      addStreamListener(holding);
                    }
                  });
                },
                chipDisplay: MultiSelectChipDisplay(
                  items: selectedHoldings
                      .map((holding) => MultiSelectItem<String>(holding, holding))
                      .toList(),
                  onTap: (value) {
                    setState(() {
                      selectedHoldings.remove(value);
                      // Remove the channel if the holding is deselected
                      prices.remove(value);
                      // Assuming WebSocketService handles this cleanup
                    });
                  },
                  chipColor: AppColors.chipColor,
                  textStyle: AppTextStyles.chipText,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: selectedHoldings.length,
                itemBuilder: (context, index) {
                  String holding = selectedHoldings[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          holding.toUpperCase(),
                          style: AppTextStyles.holdingText,
                        ),
                        Text(
                          prices[holding] ?? 'Loading...',
                          style: AppTextStyles.priceText,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
