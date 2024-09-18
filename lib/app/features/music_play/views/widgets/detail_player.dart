import 'package:flutter/material.dart';
import 'package:music_playlist/app/features/music_play/music_play.dart';



import '../../../../utils/utils.dart';
import '../../models/play_list_model.dart';
import 'seek_bar.dart';



class DetailPlayer extends StatelessWidget {

  final PlayList item;

  final double imageSize;
  final double playIconSize;
  final Color? playIconColor;
  final Icon? playIcon;
  const DetailPlayer({super.key,
    required this.item,
    this.imageSize = 52,
    this.playIconSize = 30,
    this.playIconColor,
    this.playIcon,
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
                ? const Icon(
              Icons.pause_outlined,
              color: Colors.black,
            )
                : const Icon(
              Icons.play_arrow,
              color: Colors.black,
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
            final isLast = index == MusicPlayController.to.selectedPlayList.audios.length-1;
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
                        title: Text(item.title,style: theme.textTheme.titleSmall,),
                        subtitle: Text(
                          style: theme.textTheme.bodySmall,
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
                    //await player.play();
                  },
                  icon:  Icon(
                    Icons.skip_previous_outlined,
                    color: isFirst ? Colors.grey.shade300 : Colors.black,
                  ),
                  iconSize: 40,
                  tooltip: 'Previous',
                ),
                buildPlayPauseButton(),
                IconButton(
                  onPressed: isLast ? null : () async {
                    await player.seekToNext();
                    //await player.play();
                  },
                  icon:  Icon(
                    Icons.skip_next_outlined,
                    color: isLast ? Colors.grey.shade300 : Colors.black,
                  ),
                  iconSize: 40,
                  tooltip: 'Next',
                )
              ],
            );
          });
    }

    return Column(
      children: [
        buildCurrentPlay(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: SeekBar(showTime: true,),
        ),
      ],
    );
  }
}