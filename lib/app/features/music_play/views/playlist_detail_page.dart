import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_playlist/app/features/music_play/views/widgets/detail_player.dart';
import '../controllers/playlist_detail_controller.dart';
import 'widgets/audio_list_tile.dart';

class PlaylistDetailPage extends GetView<PlayListDetailController> {
  const PlaylistDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1A3750),
        body: Column(
          children: [
            DetailPlayer(
              backgroundColor: const Color(0xFF11222F),
              item: controller.playList,
              iconColor: Colors.white,
              iconDisableColor: Colors.black.withOpacity(0.4),
              titleStyle: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
              subTitleStyle: theme.textTheme.bodySmall?.copyWith(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  color: Colors.grey,
                  width: 50,
                  height: 5,
                ),
              ),
            ),
            TabBar(
              controller: controller.tabController,
              tabs: controller.tabs,
              indicatorColor: Colors.white,
              labelColor:  Colors.white,
              unselectedLabelColor: Colors.grey,
              indicatorSize:TabBarIndicatorSize.tab,
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: controller.tabs.map((Tab tab) {
                  final String label = tab.text!;
                  if (label == controller.tabs.first.text) {
                    return ListView.separated(
                        itemBuilder: (_,index) {
                          final item = controller.audioList[index];
                          StreamBuilder<int?> buildCurrentPlay() {
                            return StreamBuilder<int?>(
                                stream: controller.player.currentIndexStream,
                                builder: (context, snapshot) {
                                  final currentIndex = snapshot.data ?? 0;
                                  final bgColor =  currentIndex == index
                                      ? const Color(0xff244f76)
                                      : const Color(0xFF1A3750);
                                  return AudioListTitle(
                                    backgroundColor:bgColor,
                                    item: item,
                                    onTap: () {
                                      controller.player.seek(Duration.zero,index: index);
                                      Future.delayed(const Duration(seconds: 1),()=> controller.player.play());
                                    },
                                    titleStyle: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
                                    subTitleStyle: theme.textTheme.bodySmall?.copyWith(color: Colors.white),
                                  );
                                });
                          }
                          return buildCurrentPlay();
                        },
                        separatorBuilder: (_,index) =>
                          const SizedBox(),
                        itemCount: controller.audioList.length
                    );
                  }
                  return Center(
                    child: Text(
                        'This is the $label tab',
                        style: const TextStyle(fontSize: 36)
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

}