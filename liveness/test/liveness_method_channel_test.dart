import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liveness/liveness_method_channel.dart';

void main() {
  MethodChannelLiveness platform = MethodChannelLiveness();
  const MethodChannel channel = MethodChannel('liveness');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.startLiveness(), '42');
  });
}
