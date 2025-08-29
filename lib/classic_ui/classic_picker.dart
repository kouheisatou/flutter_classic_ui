import 'package:flutter/material.dart';
import 'classic_theme.dart';
import 'classic_button.dart';
import 'classic_dialog.dart';

/// クラシック調の日付ピッカー
class ClassicDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime>? onChanged;

  const ClassicDatePicker({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onChanged,
  });

  @override
  State<ClassicDatePicker> createState() => _ClassicDatePickerState();

  static Future<DateTime?> show(BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    DateTime? selectedDate = initialDate;

    return showDialog<DateTime>(
      context: context,
      builder: (context) => ClassicDialog(
        title: '日付を選択',
        content: ClassicDatePicker(
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          onChanged: (date) => selectedDate = date,
        ),
        actions: [
          ClassicButton(
            text: 'キャンセル',
            onPressed: () => Navigator.of(context).pop(),
          ),
          ClassicButton(
            text: 'OK',
            onPressed: () => Navigator.of(context).pop(selectedDate),
          ),
        ],
      ),
    );
  }
}

class _ClassicDatePickerState extends State<ClassicDatePicker> {
  late DateTime _selectedDate;
  late DateTime _displayedMonth;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _displayedMonth = DateTime(_selectedDate.year, _selectedDate.month);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: ClassicTheme.raisedDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          _buildCalendar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(ClassicTheme.padding),
      decoration: const BoxDecoration(
        color: ClassicTheme.primaryColor,
        border: Border(
          bottom: BorderSide(
            color: ClassicTheme.borderColor,
            width: ClassicTheme.borderWidth,
          ),
        ),
      ),
      child: Row(
        children: [
          ClassicButton(
            text: '<',
            width: 20,
            height: 20,
            onPressed: () => _changeMonth(-1),
          ),
          Expanded(
            child: Center(
              child: Text(
                '${_displayedMonth.year}年 ${_displayedMonth.month}月',
                style: ClassicTheme.titleTextStyle.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ClassicButton(
            text: '>',
            width: 20,
            height: 20,
            onPressed: () => _changeMonth(1),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(ClassicTheme.padding),
      color: ClassicTheme.surfaceColor,
      child: Column(
        children: [
          _buildWeekHeader(),
          ..._buildWeeks(),
        ],
      ),
    );
  }

  Widget _buildWeekHeader() {
    const weekdays = ['日', '月', '火', '水', '木', '金', '土'];
    return Row(
      children: weekdays
          .map((day) => Expanded(
                child: Container(
                  height: 24,
                  alignment: Alignment.center,
                  child: Text(
                    day,
                    style: ClassicTheme.bodyTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  List<Widget> _buildWeeks() {
    final firstDayOfMonth = DateTime(_displayedMonth.year, _displayedMonth.month, 1);
    final lastDayOfMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1, 0);
    final firstDayOfCalendar = firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday % 7));

    final weeks = <Widget>[];
    var currentDate = firstDayOfCalendar;

    while (currentDate.isBefore(lastDayOfMonth) || currentDate.month == _displayedMonth.month) {
      final weekDays = <Widget>[];

      for (int i = 0; i < 7; i++) {
        weekDays.add(_buildDay(currentDate));
        currentDate = currentDate.add(const Duration(days: 1));
      }

      weeks.add(Row(children: weekDays));

      if (currentDate.month != _displayedMonth.month && currentDate.day > 7) {
        break;
      }
    }

    return weeks;
  }

  Widget _buildDay(DateTime date) {
    final isCurrentMonth = date.month == _displayedMonth.month;
    final isSelected = date.year == _selectedDate.year &&
        date.month == _selectedDate.month &&
        date.day == _selectedDate.day;
    final isToday = date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day;

    return Expanded(
      child: GestureDetector(
        onTap: isCurrentMonth ? () => _selectDate(date) : null,
        child: Container(
          height: 24,
          margin: const EdgeInsets.all(1),
          decoration: isSelected ? ClassicTheme.sunkenDecoration : null,
          child: Center(
            child: Text(
              '${date.day}',
              style: ClassicTheme.bodyTextStyle.copyWith(
                color: isCurrentMonth
                    ? (isSelected ? ClassicTheme.textColor : (isToday ? Colors.red : ClassicTheme.textColor))
                    : Colors.grey,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _changeMonth(int delta) {
    setState(() {
      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month + delta);
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    widget.onChanged?.call(date);
  }
}

/// クラシック調の時刻ピッカー
class ClassicTimePicker extends StatefulWidget {
  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay>? onChanged;

  const ClassicTimePicker({
    super.key,
    this.initialTime,
    this.onChanged,
  });

  @override
  State<ClassicTimePicker> createState() => _ClassicTimePickerState();

  static Future<TimeOfDay?> show(BuildContext context, {
    TimeOfDay? initialTime,
  }) {
    TimeOfDay? selectedTime = initialTime;

    return showDialog<TimeOfDay>(
      context: context,
      builder: (context) => ClassicDialog(
        title: '時刻を選択',
        content: ClassicTimePicker(
          initialTime: initialTime,
          onChanged: (time) => selectedTime = time,
        ),
        actions: [
          ClassicButton(
            text: 'キャンセル',
            onPressed: () => Navigator.of(context).pop(),
          ),
          ClassicButton(
            text: 'OK',
            onPressed: () => Navigator.of(context).pop(selectedTime),
          ),
        ],
      ),
    );
  }
}

class _ClassicTimePickerState extends State<ClassicTimePicker> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime ?? TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: ClassicTheme.raisedDecoration,
      child: Container(
        padding: const EdgeInsets.all(ClassicTheme.padding),
        color: ClassicTheme.surfaceColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '時刻を選択',
              style: ClassicTheme.titleTextStyle,
            ),
            const SizedBox(height: ClassicTheme.padding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTimePart(_selectedTime.hour, 24, (value) {
                  setState(() {
                    _selectedTime = _selectedTime.replacing(hour: value);
                  });
                  widget.onChanged?.call(_selectedTime);
                }),
                const Text(':', style: ClassicTheme.titleTextStyle),
                _buildTimePart(_selectedTime.minute, 60, (value) {
                  setState(() {
                    _selectedTime = _selectedTime.replacing(minute: value);
                  });
                  widget.onChanged?.call(_selectedTime);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePart(int value, int max, ValueChanged<int> onChanged) {
    return Column(
      children: [
        ClassicButton(
          text: '▲',
          width: 30,
          height: 20,
          onPressed: () => onChanged((value + 1) % max),
        ),
        Container(
          width: 40,
          height: 30,
          margin: const EdgeInsets.symmetric(vertical: 2),
          decoration: ClassicTheme.sunkenDecoration,
          child: Center(
            child: Text(
              value.toString().padLeft(2, '0'),
              style: ClassicTheme.titleTextStyle,
            ),
          ),
        ),
        ClassicButton(
          text: '▼',
          width: 30,
          height: 20,
          onPressed: () => onChanged((value - 1 + max) % max),
        ),
      ],
    );
  }
}
