import 'dart:async';
import 'package:get/get.dart';

import '../../../routes/route.dart';


class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();
    loading();
  }

  Future<void> loading() async {
    Timer(
      const Duration(seconds: 2),
      () => Get.offAndToNamed(Routes.musicPlay)
    );
  }
}
