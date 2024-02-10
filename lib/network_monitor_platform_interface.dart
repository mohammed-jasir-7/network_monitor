import 'package:network_monitor/models/network_status_model.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'network_monitor_method_channel.dart';

abstract class NetworkMonitorPlatform extends PlatformInterface {
  /// Constructs a NetworkMonitorPlatform.
  NetworkMonitorPlatform() : super(token: _token);

  static final Object _token = Object();

  static NetworkMonitorPlatform _instance = MethodChannelNetworkMonitor();

  /// The default instance of [NetworkMonitorPlatform] to use.
  ///
  /// Defaults to [MethodChannelNetworkMonitor].
  static NetworkMonitorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NetworkMonitorPlatform] when
  /// they register themselves.
  static set instance(NetworkMonitorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
///this method  will return internet status
///if  has internet it retun true otherwise false
  Future<bool?> isOnline() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  /// return Stream of type[NetworkStatus] 
  /// it will contain details 
  /// stram listen networkchanges
  Future<Stream<NetworkStatus>?> onNetworkChange() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
