import 'package:flutter/material.dart';
import 'package:music_playlist/app/features/music_play/music_play.dart';



import '../../../../utils/utils.dart';
import '../../models/play_list_model.dart';
import 'seek_bar.dart';



class DetailPlayer extends StatelessWidget {

  final PlayList item;

  final double imageSize;
  final double playIconSize;
  final Color? iconColor;
  final Color? iconDisableColor;
  final Color? backgroundColor;
  final Icon? playIcon;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  const DetailPlayer({super.key,
    required this.item,
    this.imageSize = 52,
    this.playIconSize = 30,
    this.iconColor,
    this.backgroundColor,
    this.playIcon,
    this.titleStyle,
    this.subTitleStyle,
    this.iconDisableColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final player = MusicPlayController.to.player;

    StreamBuilder<bool> buildPlayPauseButton() {
      return StreamBuilder<bool>(
        stream: player.playingStream,
        builder: (context, snapshot) {
          final playing = snapshot.data ?? false;
          debugPrint(playing ? 'Playing' : 'Not Playing');
          return IconButton(
            onPressed: () {
              if (playing) {
                player.pause();
              } else {
                if (player.position >= (player.duration ?? Duration.zero)) {
                  player.seek(Duration.zero);
                }
                player.play();
              }
            },
            icon: playing
                ?  Icon(
              Icons.pause_outlined,
              color: iconColor ?? Colors.black,
            )
                :  Icon(
              Icons.play_arrow,
              color: iconColor ?? Colors.black,
            ),
            iconSize: 40,
            tooltip: 'Play/Pause',
          );
        },
      );
    }

    StreamBuilder<int?> buildCurrentPlay() {
      return StreamBuilder<int?>(
          stream: player.currentIndexStream,
          builder: (context, snapshot) {
            final index = snapshot.data ?? 0;
            final item = MusicPlayController.to.getAudioByIndex(index);
            if (item == null) {
              return const SizedBox();
            }
            debugPrint('playing #$index');
            final isFirst = index == 0;
            final isLast = index == MusicPlayController.to.
              selectedPlayList.audios.length-1;
            return Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: imageFromSource(item.image,size: imageSize),
                        ),
                        title: Text(
                          item.title,
                          style: titleStyle ?? theme.textTheme.titleSmall,
                        ),
                        subtitle: Text(
                          style: subTitleStyle ?? theme.textTheme.bodySmall,
                          item.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: isFirst ? null : () async {
                    await player.seekToPrevious();
                  },
                  icon:  Icon(
                    Icons.skip_previous_outlined,
                    color: isFirst
                      ? ( iconDisableColor ?? Colors.grey.shade300)
                      : ( iconColor ?? Colors.black),
                  ),
                  iconSize: 40,
                  tooltip: 'Previous',
                ),
                buildPlayPauseButton(),
                IconButton(
                  onPressed: isLast ? null : () async {
                    await player.seekToNext();
                  },
                  icon:  Icon(
                    Icons.skip_next_outlined,
                    color: isLast
                      ? ( iconDisableColor ?? Colors.grey.shade300)
                      : ( iconColor ?? Colors.black),
                  ),
                  iconSize: 40,
                  tooltip: 'Next',
                )
              ],
            );
          });
    }

    return Container(
      color: backgroundColor ?? Colors.white,
      child: Column(
        children: [
          buildCurrentPlay(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SeekBar(showTime: true,timeStyle: subTitleStyle ,),
          ),
        ],
      ),
    );
  }
}