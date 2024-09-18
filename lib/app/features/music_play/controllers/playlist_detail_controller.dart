import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/play_list_model.dart';
import 'music_play_controller.dart';

class PlayListDetailController extends GetxController
    with GetSingleTickerProviderStateMixin  {
  final playList = MusicPlayController.to.selectedPlayList;
  final player = MusicPlayController.to.player;
  List<AudioItem> get audioList => playList.audios;

  final  tabs = <Tab>[
    const Tab(text: 'UP NEXT'),
    const Tab(text: 'LYRICS'),
  ];

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}