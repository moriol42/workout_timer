import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class DurationPicker extends StatefulWidget {
  const DurationPicker({super.key, this.min = 0, this.sec = 30});

  final int min;
  final int sec;

  @override
  State<DurationPicker> createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  late int _min;
  late int _sec;

  @override
  void initState() {
    super.initState();
    _min = widget.min;
    _sec = widget.sec;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        NumberPicker(
          value: _min,
          minValue: 0,
          maxValue: 60,
          onChanged: (value) => setState(() => _min = value),
        ),
        Text('min'),
        NumberPicker(
          value: _sec,
          minValue: 1,
          maxValue: 60,
          onChanged: (value) => setState(() => _sec = value),
        ),
        Text('s'),
      ],
    );
  }
}
