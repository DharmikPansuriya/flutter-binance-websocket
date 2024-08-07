import 'dart:convert';
import 'package:web_socket_channel/io.dart';

class WebSocketService {
  final String url;
  final Map<String, IOWebSocketChannel> _channels = {};
  final Map<String, Function(String)> _onUpdate = {};

  WebSocketService(this.url);

  void addListener(String holding, Function(String) onUpdateCallback) {
    if (!_channels.containsKey(holding)) {
      final urlWithPair = url.replaceAll('{pair}', holding);
      final channel = IOWebSocketChannel.connect(urlWithPair);
      _channels[holding] = channel;
      _onUpdate[holding] = onUpdateCallback;

      channel.stream.listen(
        (message) {
          try {
            final data = jsonDecode(message);
            if (data is Map<String, dynamic> && data.containsKey('p')) {
              onUpdateCallback(data['p'] as String);
            }
          } catch (e) {
            onUpdateCallback('Error');
          }
        },
        onError: (error) {
          onUpdateCallback('Error');
        },
        onDone: () {
          onUpdateCallback('Disconnected');
          _channels.remove(holding);
          _onUpdate.remove(holding);
        },
      );
    }
  }

  void dispose() {
    for (var channel in _channels.values) {
      channel.sink.close();
    }
    _channels.clear();
    _onUpdate.clear();
    
  }
}
