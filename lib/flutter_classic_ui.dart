
import 'flutter_classic_ui_platform_interface.dart';

class FlutterClassicUi {
  Future<String?> getPlatformVersion() {
    return FlutterClassicUiPlatform.instance.getPlatformVersion();
  }
}
