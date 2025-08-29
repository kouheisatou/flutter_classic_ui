import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_classic_ui_platform_interface.dart';

/// An implementation of [FlutterClassicUiPlatform] that uses method channels.
class MethodChannelFlutterClassicUi extends FlutterClassicUiPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_classic_ui');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
