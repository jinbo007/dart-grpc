import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'liveness_method_channel.dart';

abstract class LivenessPlatform extends PlatformInterface {
  /// Constructs a LivenessPlatform.
  LivenessPlatform() : super(token: _token);

  static final Object _token = Object();

  static LivenessPlatform _instance = MethodChannelLiveness();

  /// The default instance of [LivenessPlatform] to use.
  ///
  /// Defaults to [MethodChannelLiveness].
  static LivenessPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LivenessPlatform] when
  /// they register themselves.
  static set instance(LivenessPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> startLiveness() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
