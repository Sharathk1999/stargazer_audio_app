import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stargazer_app/screens/home/screen_home.dart';

import '../../../constants/const.dart';

class StarGazerBottomNavigationBar extends StatelessWidget {
  const StarGazerBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget?_) {
        return BottomNavigationBar(
          backgroundColor: bgColor2,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.black26,
        selectedLabelStyle: GoogleFonts.inconsolata(fontSize: 18),
        unselectedLabelStyle: GoogleFonts.inconsolata(),
        currentIndex: updatedIndex,
        onTap: (newIndex) {
          ScreenHome.selectedIndexNotifier.value = newIndex;
        },
        items:const [
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.magnifyingGlass),
          label: 'Search',
          ),
          BottomNavigationBarItem(icon: CircleAvatar(
            backgroundImage: AssetImage('assets/image/cd_bg_img.png'),
          ),
          label: 'Home'
          ),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.gear),
          label: 'Settings',
          
          )
        ],
      );
      },
    );
  }
}