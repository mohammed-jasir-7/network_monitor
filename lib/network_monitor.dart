
import 'package:network_monitor/models/network_status_model.dart';

import 'network_monitor_platform_interface.dart';

class NetworkMonitor {
  Future<bool?> isOnline() {
    return NetworkMonitorPlatform.instance.isOnline();
  }
  Future<Stream<NetworkStatus>?> onChange() {
    return NetworkMonitorPlatform.instance.onNetworkChange();
  }
}
