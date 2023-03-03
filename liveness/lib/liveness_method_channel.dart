import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'liveness_platform_interface.dart';

/// An implementation of [LivenessPlatform] that uses method channels.
class MethodChannelLiveness extends LivenessPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('liveness');

  @override
  Future<String?> startLiveness() async {
    final version = await methodChannel.invokeMethod<String>('startLiveness');
    return version;
  }
}
