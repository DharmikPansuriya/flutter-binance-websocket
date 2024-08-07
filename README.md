# Live Crypto Tracker

A Flutter application that connects to WebSocket streams to receive live cryptocurrency prices and display the latest price of selected holdings.

## Features

- Connects to a WebSocket server to receive live data streams.
- Displays the latest price of selected holdings.
- Allows users to select and deselect holdings dynamically.
- Handles WebSocket connection errors and updates the UI accordingly.
- Optimized for performance and efficient resource management.

## Installation

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart: Comes with Flutter SDK
- A WebSocket server URL for live data (e.g., a test WebSocket server)

### Setup

1. Clone the repository:

   ```sh
   git clone https://github.com/DharmikPansuriya/flutter-binance-websocket.git
   cd flutter-binance-websocket

2. Install dependencies:
   ```sh
   flutter pub get
   
3. Create a .env file in the root directory and add your WebSocket URL:
   ```sh
   MASTER_WEBSOCKET_URL=ws://your.websocket.url/{pair}

5. Run the application:
   ```sh
   flutter run
