import 'package:get/get.dart';

import '../controllers/playlist_detail_controller.dart';

class PlaylistDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PlayListDetailController());
  }
}