
import 'package:get/get.dart';


import '../features/music_play/music_play.dart';
import '../features/splash/splash.dart';


class Routes {
  static const  splash = '/splash';
  static const musicPlay = '/music_play';

  static final routes = [

    GetPage(name: splash , page: () => const SplashPage(), binding: SplashBinding(), transition: Transition.cupertino),


    GetPage(name: musicPlay, page: () => const MusicPlayPage(), binding: MusicPlayBinding(), transition: Transition.cupertino),
  ];
}
