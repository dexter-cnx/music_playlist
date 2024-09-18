import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'initial/initial.dart';
import 'routes/route.dart';
import 'utils/utils.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Music Playlist',
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      defaultTransition: Transition.cupertino,
      initialRoute: Routes.splash,
      getPages: Routes.routes,
      builder: EasyLoading.init(
        builder: (context, widget) {
        return MediaQuery(data: MediaQuery.of(context), child: widget!);
      }),
      theme: ThemeData(
        textTheme: GoogleFonts.kanitTextTheme(Theme.of(context).textTheme),
        primaryColorLight: const Color(0xFFC9DA2A),
        primarySwatch: generateMaterialColor(const Color(0xFFC9DA2A)),
        brightness: Brightness.light,
      ),
    );
  }
}
