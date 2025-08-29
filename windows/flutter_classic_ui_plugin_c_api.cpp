#include "include/flutter_classic_ui/flutter_classic_ui_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_classic_ui_plugin.h"

void FlutterClassicUiPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_classic_ui::FlutterClassicUiPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
