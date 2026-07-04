import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'dart:async';

class ShareIntentHandler {
  static StreamSubscription? _intentDataStreamSubscription;

  static void init({required Function(String) onUrlReceived}) {
    // For sharing or opening coming from outside the app while the app is in the memory
    _intentDataStreamSubscription = ReceiveSharingIntent.instance.getMediaStream().listen((value) {
      for (var file in value) {
        if (file.path.startsWith('http')) {
          onUrlReceived(file.path);
          break;
        }
      }
    });

    // For sharing or opening coming from outside the app while the app is closed
    ReceiveSharingIntent.instance.getInitialMedia().then((value) {
      for (var file in value) {
        if (file.path.startsWith('http')) {
          onUrlReceived(file.path);
          break;
        }
      }
    });
  }

  static void dispose() {
    _intentDataStreamSubscription?.cancel();
  }
}
