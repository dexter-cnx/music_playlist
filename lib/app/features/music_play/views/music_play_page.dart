
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/play_list_player.dart';
import 'widgets/playlist_list_title.dart';
import '../controllers/music_play_controller.dart';

class MusicPlayPage extends GetView<MusicPlayController> {
  const MusicPlayPage({super.key});


  @override
  Widget build(BuildContext context) {
    const loadingSize = 50.0;
    //final theme = Theme.of(context);
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Music PlayList'),
        centerTitle: false,
      ),
      body: Obx(()=> controller.isLoading
          ? const Center(
              child: SizedBox(
                  width: loadingSize ,height: loadingSize,
                  child: CircularProgressIndicator()
              ),
            )
                : ListView.separated(
                itemBuilder: (_,index) {
                  final item = controller.lists[index];
                  return PlaylistListTitle(
                    item: item,
                    onPlay: () => controller.play(item),
                    onTap: () => controller.playListDetail(item)
                  );
                  // return ListTile(
                  //   leading: const Icon(Icons.music_note,size: 50,color: Colors.redAccent,),
                  //   title: Text(item.title,style: theme.textTheme.titleSmall,),
                  //   subtitle: Text(item.description,style: theme.textTheme.bodySmall,),
                  //   trailing:  InkWell(
                  //     onTap: (){
                  //       const assetPath = 'assets/mp3/nature.mp3';//''assets/mp3/inspiring-corporate-technology-ambient-loyalty-no-drums-236311.mp3';
                  //       controller.playAsset(assetPath);
                  //     },
                  //     child: Icon(Icons.play_circle_outline,size: 30,color: Colors.grey.shade400)
                  //   ),
                  // );
                },
                separatorBuilder: (_,index) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Divider(
                      color: Colors.grey.shade200,
                    ),
                  ),
                itemCount: controller.lists.length
            )
        ),
        bottomNavigationBar: Obx(() {
          if (controller.selectedPlayList.id < 1) {
            return const SizedBox();
          }
          return SizedBox(height: 200,
            child:  PlayListPlayer(
              item: controller.selectedPlayList,
            )
          );
        }),
    );
  }

}