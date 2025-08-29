import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_classic_ui/flutter_classic_ui.dart';
import 'package:flutter_classic_ui/flutter_classic_ui_platform_interface.dart';
import 'package:flutter_classic_ui/flutter_classic_ui_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterClassicUiPlatform
    with MockPlatformInterfaceMixin
    implements FlutterClassicUiPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterClassicUiPlatform initialPlatform = FlutterClassicUiPlatform.instance;

  test('$MethodChannelFlutterClassicUi is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterClassicUi>());
  });

  test('getPlatformVersion', () async {
    FlutterClassicUi flutterClassicUiPlugin = FlutterClassicUi();
    MockFlutterClassicUiPlatform fakePlatform = MockFlutterClassicUiPlatform();
    FlutterClassicUiPlatform.instance = fakePlatform;

    expect(await flutterClassicUiPlugin.getPlatformVersion(), '42');
  });
}
