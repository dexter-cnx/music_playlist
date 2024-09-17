import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:just_audio/just_audio.dart';
//import 'package:audioplayers/audioplayers.dart';

import '../models/play_list_model.dart';

class MusicPlayController extends GetxController {

  final player = AudioPlayer();


  final _loading = true.obs;
  bool get isLoading => _loading.isTrue;

  final _lists = <PlayList>[].obs;
  List<PlayList> get lists => _lists;

  @override
  void onInit() {
    loadPlayList();

    //_initStreams();
    super.onInit();
  }

  Future<void> loadPlayList() async {
    _loading(true);
    const playListAsset = 'assets/jsons/music_list.json';

    final jsonText = await rootBundle.loadString(playListAsset);
    final playListModel = PlayListModel.fromJson(jsonText);
    _lists.clear();
    _lists.addAll( playListModel.lists );
    _loading(false);
  }

  Future<void> play(String source) async {
    if (source.contains('http')) {
      await player.setUrl(source);
      await player.play();
    } else if (source.contains('asset')) {
      await player.setAsset(source);
      await player.play();
    }
  }

  void playListDetail(PlayList playList) {

  }



}