import 'package:flutter/material.dart';

class ClassicDateTimePicker extends StatefulWidget {
  final DateTime? value;
  final ValueChanged<DateTime?>? onChanged;
  final String? label;
  final String? Function(DateTime?)? validator;

  const ClassicDateTimePicker({
    super.key,
    this.value,
    this.onChanged,
    this.label,
    this.validator,
  });

  @override
  State<ClassicDateTimePicker> createState() => _ClassicDateTimePickerState();
}

class _ClassicDateTimePickerState extends State<ClassicDateTimePicker> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: _errorText != null ? Colors.red : Colors.black,
              width: 1,
            ),
          ),
          child: InkWell(
            onTap: () => _selectDateTime(context),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.value != null
                          ? '${widget.value!.year}/${widget.value!.month.toString().padLeft(2, '0')}/${widget.value!.day.toString().padLeft(2, '0')} ${widget.value!.hour.toString().padLeft(2, '0')}:${widget.value!.minute.toString().padLeft(2, '0')}'
                          : '日時を選択してください',
                      style: TextStyle(
                        color: widget.value != null ? Colors.black : Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const Icon(Icons.calendar_today, size: 16),
                ],
              ),
            ),
          ),
        ),
        if (_errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            _errorText!,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: widget.value ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(widget.value ?? DateTime.now()),
      );

      if (time != null && mounted) {
        final dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
        widget.onChanged?.call(dateTime);

        // バリデーション実行
        if (widget.validator != null) {
          setState(() {
            _errorText = widget.validator!(dateTime);
          });
        }
      }
    }
  }

  void validate() {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(widget.value);
      });
    }
  }
}
