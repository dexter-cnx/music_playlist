import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_playlist/app/features/music_play/views/widgets/detail_player.dart';
import '../controllers/playlist_detail_controller.dart';

class PlaylistDetailPage extends GetView<PlayListDetailController> {
  const PlaylistDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            DetailPlayer(item: controller.playList),
          ],
        ),
      ),
    );
  }

}