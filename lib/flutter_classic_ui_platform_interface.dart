import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_classic_ui_method_channel.dart';

abstract class FlutterClassicUiPlatform extends PlatformInterface {
  /// Constructs a FlutterClassicUiPlatform.
  FlutterClassicUiPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterClassicUiPlatform _instance = MethodChannelFlutterClassicUi();

  /// The default instance of [FlutterClassicUiPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterClassicUi].
  static FlutterClassicUiPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterClassicUiPlatform] when
  /// they register themselves.
  static set instance(FlutterClassicUiPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
