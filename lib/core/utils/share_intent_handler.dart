import 'dart:async';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import '../../features/home/bloc/extraction_bloc.dart';

class ShareIntentHandler {
  final ExtractionBloc extractionBloc;
  static StreamSubscription? _intentDataStreamSubscription;

  ShareIntentHandler(this.extractionBloc);

  void init() {
    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription = ReceiveSharingIntent.instance.getMediaStream().listen((List<SharedMediaFile> value) {
      if (value.isNotEmpty && value.first.path.isNotEmpty) {
        extractionBloc.add(LinkPasted(value.first.path));
      }
    }, onError: (err) {
      // ignore: avoid_print
      print("getLinkStream error: $err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.instance.getInitialMedia().then((List<SharedMediaFile> value) {
      if (value.isNotEmpty && value.first.path.isNotEmpty) {
        extractionBloc.add(LinkPasted(value.first.path));
      }
    });
  }

  static void dispose() {
    _intentDataStreamSubscription?.cancel();
  }
}
