import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class DurationPicker extends StatefulWidget {
  const DurationPicker({super.key, this.text, this.controller, this.onChanged});

  final String? text;
  final DurationPickerController? controller;
  final Function()? onChanged;

  @override
  State<DurationPicker> createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  late int _min;
  late int _sec;

  @override
  void initState() {
    super.initState();
    _min = widget.controller?.duration.inMinutes ?? 0;
    _sec = (widget.controller?.duration.inSeconds ?? 30) % 60;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (widget.text != null) Flexible(child: Text(widget.text!)),
        NumberPicker(
          value: _min,
          minValue: 0,
          maxValue: 60,
          onChanged: (value) {
            setState(() {
              _min = value;
              widget.controller?.duration = Duration(
                minutes: _min,
                seconds: _sec,
              );
            });
            if (widget.onChanged != null) widget.onChanged!();
          },
        ),
        Text('min'),
        NumberPicker(
          value: _sec,
          minValue: 1,
          maxValue: 60,
          onChanged: (value) {
            setState(() {
              _sec = value;
              widget.controller?.duration = Duration(
                minutes: _min,
                seconds: _sec,
              );
            });
            if (widget.onChanged != null) widget.onChanged!();
          },
        ),
        Text('s'),
      ],
    );
  }
}

class DurationPickerController {
  DurationPickerController({this.duration = const Duration(seconds: 0)});

  Duration duration;
}
