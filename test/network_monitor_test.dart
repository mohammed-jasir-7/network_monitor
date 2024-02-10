import 'package:flutter_test/flutter_test.dart';
import 'package:network_monitor/models/network_status_model.dart';
import 'package:network_monitor/network_monitor.dart';
import 'package:network_monitor/network_monitor_platform_interface.dart';
import 'package:network_monitor/network_monitor_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNetworkMonitorPlatform
    with MockPlatformInterfaceMixin
    implements NetworkMonitorPlatform {


  
  @override
  Future<bool?> isOnline() {
    // TODO: implement isOnline
    throw UnimplementedError();
  }
  
  @override
  Future<Stream<NetworkStatus>?> onNetworkChange() {
    // TODO: implement onNetworkChange
    throw UnimplementedError();
  }
}

void main() {
  final NetworkMonitorPlatform initialPlatform = NetworkMonitorPlatform.instance;

  test('$MethodChannelNetworkMonitor is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNetworkMonitor>());
  });

  test('getPlatformVersion', () async {
    NetworkMonitor networkMonitorPlugin = NetworkMonitor();
    MockNetworkMonitorPlatform fakePlatform = MockNetworkMonitorPlatform();
    NetworkMonitorPlatform.instance = fakePlatform;

    expect(true, '42');
  });
}
