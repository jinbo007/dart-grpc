import 'package:flutter_test/flutter_test.dart';
import 'package:liveness/liveness.dart';
import 'package:liveness/liveness_platform_interface.dart';
import 'package:liveness/liveness_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLivenessPlatform
    with MockPlatformInterfaceMixin
    implements LivenessPlatform {

  @override
  Future<String?> startLiveness() => Future.value('42');
}

void main() {
  final LivenessPlatform initialPlatform = LivenessPlatform.instance;

  test('$MethodChannelLiveness is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLiveness>());
  });

  test('getPlatformVersion', () async {
    Liveness livenessPlugin = Liveness();
    MockLivenessPlatform fakePlatform = MockLivenessPlatform();
    LivenessPlatform.instance = fakePlatform;

    expect(await livenessPlugin.getPlatformVersion(), '42');
  });
}
