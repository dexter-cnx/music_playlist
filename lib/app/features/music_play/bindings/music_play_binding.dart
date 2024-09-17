import 'package:get/get.dart';
import '../controllers/music_play_controller.dart';

class MusicPlayBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MusicPlayController());
  }
}
