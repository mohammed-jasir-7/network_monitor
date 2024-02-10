import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_monitor/network_monitor_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelNetworkMonitor platform = MethodChannelNetworkMonitor();
  const MethodChannel channel = MethodChannel('network_monitor');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.isOnline(), '42');
  });
}
