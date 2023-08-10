import 'package:flutter/material.dart';
import 'package:stargazer_app/screens/home/widgets/bottom_nav_bar.dart';
import 'package:stargazer_app/screens/search/screen_search.dart';
import 'package:stargazer_app/screens/settings/screen_settings.dart';
import 'package:stargazer_app/screens/songs/screen_all_songs.dart';

import '../../constants/const.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(1);

  final _pages = const [
    ScreenSearchSong(),
    ScreenAllSongs(),
    ScreenSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      bottomNavigationBar: const StarGazerBottomNavigationBar(),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: selectedIndexNotifier,
        builder: (BuildContext context, int updatedIndex, Widget? _) {
          return Stack(
            children: [
              _pages[updatedIndex],
            ],
          );
        },
      )),
    );
  }
}
