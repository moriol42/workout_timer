import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import '../types/workout.dart';
import '../widgets/congratulation_dialog.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key, required this.workout});

  final Workout workout;

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    widget.workout.resetIterator();

    return Scaffold(
      appBar: AppBar(title: Text(widget.workout.name)),
      body: Center(
        child: CircularCountDownTimer(
          duration: widget.workout.current!.$2.inSeconds,
          controller: _controller,
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 2,
          ringColor: Colors.grey[300]!,
          fillColor: theme.primaryColor,
          strokeWidth: 15.0,
          strokeCap: StrokeCap.round,
          textStyle: const TextStyle(
            fontSize: 33.0,
            fontWeight: FontWeight.bold,
          ),
          textFormat: CountdownTextFormat.S,
          isReverse: true,
          isReverseAnimation: true,
          onComplete: () {
            if (widget.workout.moveNext()) {
              _controller.restart(
                duration: widget.workout.current!.$2.inSeconds,
              );
            } else {
              Navigator.of(context).push(GongratulationDialog<void>());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.isPaused.value) {
            _controller.resume();
          } else {
            _controller.pause();
          }
          setState(() {});
        },
        child: Icon(
          _controller.isPaused.value ? Icons.play_arrow : Icons.pause,
        ),
      ),
    );
  }
}
