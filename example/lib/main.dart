import 'package:flutter/material.dart';
import 'package:flutter_classic_ui/classic_ui/classic_button.dart';
import 'package:flutter_classic_ui/classic_ui/classic_controls.dart';
import 'package:flutter_classic_ui/classic_ui/classic_card.dart';
import 'package:flutter_classic_ui/classic_ui/classic_dialog.dart';
import 'package:flutter_classic_ui/classic_ui/classic_list.dart';
import 'package:flutter_classic_ui/classic_ui/classic_menu.dart';
import 'package:flutter_classic_ui/classic_ui/classic_notification.dart';
import 'package:flutter_classic_ui/classic_ui/classic_picker.dart';
import 'package:flutter_classic_ui/classic_ui/classic_progress.dart';
import 'package:flutter_classic_ui/classic_ui/classic_toolbar.dart';
import 'package:flutter_classic_ui/classic_ui/classic_window.dart';
import 'package:flutter_classic_ui/classic_ui/classic_text_field.dart';
import 'package:flutter_classic_ui/classic_ui/classic_theme.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Classic UI Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainMenu(),
        ButtonDemo.routeName: (context) => const ButtonDemo(),
        ControlsDemo.routeName: (context) => const ControlsDemo(),
        CardDemo.routeName: (context) => const CardDemo(),
        TextFieldDemo.routeName: (context) => const TextFieldDemo(),
        DateTimePickerDemo.routeName: (context) => const DateTimePickerDemo(),
        DialogDemo.routeName: (context) => const DialogDemo(),
        ListDemo.routeName: (context) => const ListDemo(),
        MenuDemo.routeName: (context) => const MenuDemo(),
        NotificationDemo.routeName: (context) => const NotificationDemo(),
        PickerDemo.routeName: (context) => const PickerDemo(),
        ProgressDemo.routeName: (context) => const ProgressDemo(),
        ToolbarDemo.routeName: (context) => const ToolbarDemo(),
        WindowDemo.routeName: (context) => const WindowDemo(),
      },
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  static final List<Map<String, String>> _items = [
    {'title': 'Button', 'route': ButtonDemo.routeName},
    {'title': 'Controls (Checkbox/Radio/Switch/Slider)', 'route': ControlsDemo.routeName},
    {'title': 'Card', 'route': CardDemo.routeName},
    {'title': 'Text Field', 'route': TextFieldDemo.routeName},
    {'title': 'Date/Time Picker', 'route': DateTimePickerDemo.routeName},
    {'title': 'Dialog', 'route': DialogDemo.routeName},
    {'title': 'List', 'route': ListDemo.routeName},
    {'title': 'Menu', 'route': MenuDemo.routeName},
    {'title': 'Notification', 'route': NotificationDemo.routeName},
    {'title': 'Picker', 'route': PickerDemo.routeName},
    {'title': 'Progress', 'route': ProgressDemo.routeName},
    {'title': 'Toolbar', 'route': ToolbarDemo.routeName},
    {'title': 'Window (サンプル)', 'route': WindowDemo.routeName},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('flutter_classic_ui デモ')),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return ListTile(
            title: Text(item['title']!),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, item['route']!),
          );
        },
      ),
    );
  }
}

// --- 各デモページ ---
class ButtonDemo extends StatelessWidget {
  static const routeName = '/button';
  const ButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button デモ')),
      body: Center(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ClassicButton(text: 'Normal', onPressed: () {}),
            ClassicButton(text: 'Primary', variant: ClassicButtonVariant.primary, onPressed: () {}),
            ClassicButton(text: 'Danger', variant: ClassicButtonVariant.danger, onPressed: () {}),
            ClassicButton(text: 'Disabled', onPressed: null, enabled: false),
          ],
        ),
      ),
    );
  }
}

class ControlsDemo extends StatefulWidget {
  static const routeName = '/controls';
  const ControlsDemo({Key? key}) : super(key: key);

  @override
  State<ControlsDemo> createState() => _ControlsDemoState();
}

class _ControlsDemoState extends State<ControlsDemo> {
  bool checkboxValue = false;
  String? radioValue = 'one';
  bool switchValue = false;
  double sliderValue = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Controls デモ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClassicCheckbox(value: checkboxValue, onChanged: (v) => setState(() => checkboxValue = v ?? false), label: 'チェック'),
            const SizedBox(height: 12),
            Row(children: [
              ClassicRadio<String>(value: 'one', groupValue: radioValue, onChanged: (v) => setState(() => radioValue = v), label: 'One'),
              const SizedBox(width: 12),
              ClassicRadio<String>(value: 'two', groupValue: radioValue, onChanged: (v) => setState(() => radioValue = v), label: 'Two'),
            ]),
            const SizedBox(height: 12),
            ClassicSwitch(value: switchValue, onChanged: (v) => setState(() => switchValue = v), label: 'スイッチ'),
            const SizedBox(height: 12),
            ClassicSlider(value: sliderValue, onChanged: (v) => setState(() => sliderValue = v), min: 0, max: 100, label: 'スライダー', width: 240),
            const SizedBox(height: 8),
            Text('値: ${sliderValue.toStringAsFixed(1)}'),
          ],
        ),
      ),
    );
  }
}

class CardDemo extends StatelessWidget {
  static const routeName = '/card';
  const CardDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card デモ')),
      body: Center(
        child: ClassicCard(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('クラシックカード', style: ClassicTheme.titleTextStyle),
                SizedBox(height: 8),
                Text('これはサンプルのカードです。'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldDemo extends StatefulWidget {
  static const routeName = '/text_field';
  const TextFieldDemo({Key? key}) : super(key: key);

  @override
  State<TextFieldDemo> createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TextField デモ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClassicTextField(controller: _controller, hintText: 'ここに入力'),
            const SizedBox(height: 12),
            ClassicButton(text: 'クリア', onPressed: () => _controller.clear()),
            const SizedBox(height: 8),
            Text('入力: ${_controller.text}'),
          ],
        ),
      ),
    );
  }
}

class DateTimePickerDemo extends StatefulWidget {
  static const routeName = '/date_time_picker';
  const DateTimePickerDemo({Key? key}) : super(key: key);

  @override
  State<DateTimePickerDemo> createState() => _DateTimePickerDemoState();
}

class _DateTimePickerDemoState extends State<DateTimePickerDemo> {
  DateTime selected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Date/Time Picker デモ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('選択: ${selected.toLocal()}'),
            const SizedBox(height: 12),
            ClassicButton(text: '日付選択', onPressed: () async {
              final d = await ClassicDatePicker.show(context, initialDate: selected);
              if (!mounted) return;
              if (d != null) setState(() => selected = d);
            }),
          ],
        ),
      ),
    );
  }
}

class DialogDemo extends StatelessWidget {
  static const routeName = '/dialog';
  const DialogDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dialog デモ')),
      body: Center(
        child: ClassicButton(
          text: 'ダイアログを表示',
          onPressed: () => ClassicDialog.showInfo(context, title: '確認', message: 'これはクラシックダイアログです。'),
        ),
      ),
    );
  }
}

class ListDemo extends StatelessWidget {
  static const routeName = '/list';
  const ListDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List デモ')),
      body: ClassicList(children: List.generate(10, (i) => ClassicListItem(title: Text('Item #$i')))),
    );
  }
}

class MenuDemo extends StatefulWidget {
  static const routeName = '/menu';
  const MenuDemo({Key? key}) : super(key: key);

  @override
  State<MenuDemo> createState() => _MenuDemoState();
}

class _MenuDemoState extends State<MenuDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu デモ')),
      body: Center(
        child: ClassicButton(text: 'メニュー表示', onPressed: () async {
          final selected = await ClassicBottomSheet.show<String>(
            context,
            child: ClassicList(children: [
              ClassicListItem(title: const Text('One'), onTap: () => Navigator.of(context).pop('One')),
              ClassicListItem(title: const Text('Two'), onTap: () => Navigator.of(context).pop('Two')),
              ClassicListItem(title: const Text('Three'), onTap: () => Navigator.of(context).pop('Three')),
            ]),
          );
          if (!mounted) return;
          if (selected != null) ClassicSnackBar.show(context, message: '選択: $selected');
        }),
      ),
    );
  }
}

class NotificationDemo extends StatelessWidget {
  static const routeName = '/notification';
  const NotificationDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification デモ')),
      body: Center(
        child: ClassicButton(text: '通知', onPressed: () => ClassicSnackBar.show(context, message: '通知メッセージ')),
      ),
    );
  }
}

class PickerDemo extends StatefulWidget {
  static const routeName = '/picker';
  const PickerDemo({Key? key}) : super(key: key);

  @override
  State<PickerDemo> createState() => _PickerDemoState();
}

class _PickerDemoState extends State<PickerDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Picker デモ')),
      body: Center(
        child: ClassicButton(text: '選択', onPressed: () async {
          final v = await ClassicBottomSheet.show<String>(
            context,
            child: ClassicList(children: [
              ClassicListItem(title: const Text('A'), onTap: () => Navigator.of(context).pop('A')),
              ClassicListItem(title: const Text('B'), onTap: () => Navigator.of(context).pop('B')),
              ClassicListItem(title: const Text('C'), onTap: () => Navigator.of(context).pop('C')),
            ]),
          );
          if (!mounted) return;
          if (v != null) ClassicSnackBar.show(context, message: '選択: $v');
        }),
      ),
    );
  }
}

class ProgressDemo extends StatefulWidget {
  static const routeName = '/progress';
  const ProgressDemo({Key? key}) : super(key: key);

  @override
  State<ProgressDemo> createState() => _ProgressDemoState();
}

class _ProgressDemoState extends State<ProgressDemo> {
  double progress = 0.2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress デモ')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClassicProgressBar(value: progress),
            const SizedBox(height: 12),
            ClassicButton(text: '進める', onPressed: () => setState(() => progress = (progress + 0.1).clamp(0.0, 1.0))),
          ],
        ),
      ),
    );
  }
}

class ToolbarDemo extends StatelessWidget {
  static const routeName = '/toolbar';
  const ToolbarDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toolbar デモ')),
      body: const Column(
        children: [
          ClassicToolbar(leading: Text('ツールバーサンプル')),
        ],
      ),
    );
  }
}

class WindowDemo extends StatelessWidget {
  static const routeName = '/window';
  const WindowDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Window デモ')),
      body: Center(
        child: ClassicWindow(
          title: 'サンプルウィンドウ',
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('ウィンドウの中身', style: ClassicTheme.bodyTextStyle),
          ),
        ),
      ),
    );
  }
}
