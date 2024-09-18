import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:just_audio/just_audio.dart';
//import 'package:audioplayers/audioplayers.dart';

import '../../../routes/route.dart';
import '../models/play_list_model.dart';

class MusicPlayController extends GetxController {

  static MusicPlayController get to => Get.find();

  final player = AudioPlayer();

  final _loading = true.obs;
  bool get isLoading => _loading.isTrue;

  final _lists = <PlayList>[].obs;
  List<PlayList> get lists => _lists;

  @override
  void onInit() {
    loadPlayList();
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

  final _selectedPlayList = PlayList.fromMap({}).obs;
  PlayList get selectedPlayList => _selectedPlayList.value;

  Future<void> play(PlayList playList,{bool isPlay = true}) async {
    if (playList.id != selectedPlayList.id) {
      if (playList.audios.isNotEmpty) {
        final sources = <AudioSource>[];
        for (final audio in playList.audios) {
          final source =  audio.source;
          if (source.contains('http')) {
            sources.add( AudioSource.uri(Uri.parse(source)) );
          } else if (source.contains('asset')) {
            sources.add( AudioSource.asset(source) );
          }
        }
        final playlist = ConcatenatingAudioSource(
          // Start loading next item just before reaching it
          useLazyPreparation: true,
          // Customise the shuffle algorithm
          shuffleOrder: DefaultShuffleOrder(),
          // Specify the playlist items
          children: sources
        );

        await player.setAudioSource(playlist, initialIndex: 0, initialPosition: Duration.zero);
        _selectedPlayList(playList);
        if (isPlay) {
          Future.delayed(const Duration(seconds: 1),()=> player.play());
        }
      }
    }
  }

  Future<void> playSource(String source) async {
    if (source.contains('http')) {
      await player.setUrl(source);
      await player.play();
    } else if (source.contains('asset')) {
      await player.setAsset(source);
      await player.play();
    }
  }

  AudioItem? getAudioByIndex(int index) {
    if (selectedPlayList.audios.length > index) {
      return selectedPlayList.audios[index];
    }
    return null;
  }

  bool isEndList() {
    return player.currentIndex == selectedPlayList.audios.length-1;
  }

  void playListDetail(PlayList playList) async {
    EasyLoading.show(status: 'Loading');
    await play(playList,isPlay: false);
    EasyLoading.dismiss();
    Get.toNamed(Routes.playListDetail);
  }
}