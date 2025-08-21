import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../types/workout.dart';
import '../widgets/congratulation_dialog.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key, required this.workout});

  final Workout workout;

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final player = AudioPlayer();
  final x = AudioCache();
  final CountDownController _controller = CountDownController();
  int oldSec = 0;

  @override
  void initState() {
    super.initState();
    widget.workout.resetIterator();

    player.setReleaseMode(ReleaseMode.stop);

    WakelockPlus.enable();
  }

  @override
  void dispose() {
    player.dispose();
    WakelockPlus.disable();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.workout.name)),
      body: Column(
        children: [
          Text(
            widget.workout.current?.$1.name ?? '',
            style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
          ),
          Center(
            child: CircularCountDownTimer(
              duration: widget.workout.current!.$2.inSeconds,
              controller: _controller,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              ringColor: theme.colorScheme.brightness == Brightness.dark
                  ? Colors.grey[800]!
                  : Colors.grey[300]!,
              fillColor: theme.colorScheme.primary,
              strokeWidth: 15.0,
              strokeCap: StrokeCap.round,
              textStyle: const TextStyle(
                fontSize: 33.0,
                fontWeight: FontWeight.bold,
              ),
              textFormat: CountdownTextFormat.S,
              isReverse: true,
              isReverseAnimation: true,
              onComplete: () async {
                await player.play(AssetSource('gong.mp3'));

                if (widget.workout.moveNext()) {
                  _controller.restart(
                    duration: widget.workout.current!.$2.inSeconds,
                  );

                  setState(() {});
                } else {
                  Navigator.of(context).push(GongratulationDialog<void>());
                }
              },
              onChange: (value) async {
                int sec = int.parse(value);
                if (oldSec != sec) {
                  if (sec < 5) {
                    await player.play(AssetSource('beep.mp3'));
                  }
                  oldSec = sec;
                }
              },
            ),
          ),
          if (widget.workout.next != null)
            Text('Next exercise is: ${widget.workout.next!.$1.name}'),
        ],
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
