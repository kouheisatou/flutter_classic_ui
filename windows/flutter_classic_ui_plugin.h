#ifndef FLUTTER_PLUGIN_FLUTTER_CLASSIC_UI_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_CLASSIC_UI_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_classic_ui {

class FlutterClassicUiPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterClassicUiPlugin();

  virtual ~FlutterClassicUiPlugin();

  // Disallow copy and assign.
  FlutterClassicUiPlugin(const FlutterClassicUiPlugin&) = delete;
  FlutterClassicUiPlugin& operator=(const FlutterClassicUiPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_classic_ui

#endif  // FLUTTER_PLUGIN_FLUTTER_CLASSIC_UI_PLUGIN_H_
