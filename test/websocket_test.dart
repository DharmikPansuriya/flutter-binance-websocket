// File: test/websocket_test.dart

import 'dart:convert';
import 'dart:async'; // Import StreamController
import 'package:test/test.dart';
import 'package:web_socket_channel/io.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_web_socket/services/websocket_service.dart'; // Adjust import according to your file structure
// import 'mocks/mock_io_websocket_channel.dart'; // Adjust import according to your file structure

class MockIOWebSocketChannel extends Mock implements IOWebSocketChannel {}

void main() {
  test('WebSocketService handles data correctly', () {
    // Create a mock WebSocket channel
    final channel = MockIOWebSocketChannel();

    // Create a StreamController to control the mock stream
    final controller = StreamController<String>.broadcast();
    
    // Mock the stream property to return the controller's stream
    when(channel.stream).thenReturn(controller.stream);

    // Create the WebSocketService with a mock URL and the mock channel
    final service = WebSocketService('ws://mockurl/{pair}');
    
    // Register a listener for 'BTC/USDT'
    service.addListener('BTC/USDT', (price) {
      expect(price, '123.45');
    });

    // Add data to the stream
    controller.sink.add(jsonEncode({'p': '123.45'}));

    // Close the controller
    controller.close();
  });
}