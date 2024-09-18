import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../controllers/music_play_controller.dart';



class SeekBar extends StatelessWidget {
  final bool showTime;
  const SeekBar({
    super.key,
    //required this.player,
    this.showTime = true
  });

  //final AudioPlayer player;

  @override
  Widget build(BuildContext context) {
    final AudioPlayer player = MusicPlayController.to.player;
    return StreamBuilder<Duration>(
      stream: player.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data ?? Duration.zero;
        return StreamBuilder<Duration?>(
          stream: player.durationStream,
          builder: (context, snapshot) {
            final duration = snapshot.data ?? Duration.zero;
            if (position >= duration && MusicPlayController.to.isEndList()) {
              player.stop();
            }
            return Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                      //trackHeight: 28,
                      thumbColor: Colors.transparent,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0.0)),
                  child: Slider(
                    activeColor: Colors.amberAccent,
                    value: position > duration
                        ? duration.inMilliseconds.toDouble()
                        : position.inMilliseconds.toDouble(),
                    min: 0,
                    max: duration.inMilliseconds.toDouble(),
                    onChanged: (value) {
                      player.seek(Duration(milliseconds: value.toInt()));
                    },
                  ),
                ),
                //const SizedBox(height: 4),
                // position and duration text
                if (showTime)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${position.inMinutes.toString().padLeft(2, '0')}:${(position.inSeconds % 60).toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}