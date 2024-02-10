import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:network_monitor/models/network_status_model.dart';

import 'network_monitor_platform_interface.dart';

/// An implementation of [NetworkMonitorPlatform] that uses method channels.
class MethodChannelNetworkMonitor extends NetworkMonitorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('network_monitor');
  final eventChannel = const EventChannel('network_stream', JSONMethodCodec());

  @override
  Future<bool?> isOnline() async {
    final version = await methodChannel.invokeMethod<bool>('isOnline');
    await methodChannel.invokeMethod<bool>("turnOnData");
    return version;
  }

  @override
  Future<Stream<NetworkStatus>?> onNetworkChange() async {
    await methodChannel.invokeMethod<bool>('onChange');

    var mapStream = eventChannel.receiveBroadcastStream().map((event) {
      log(event["status"]);
      return NetworkStatus(status: event["status"]);
    });
  

    return mapStream;
  }
}
