
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/music_play_controller.dart';

class MusicPlayPage extends GetView<MusicPlayController> {
  const MusicPlayPage({super.key});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Music PlayList'),
        centerTitle: false,
      ),
      body: const Column(
        children: [
          Text('test'),
        ],
      ),
    );
  }

}