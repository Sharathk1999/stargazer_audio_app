import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stargazer_app/constants/const.dart';
import 'package:stargazer_app/functions/song_fetch.dart';
import 'package:stargazer_app/screens/playlist/screen_playlist.dart';

class ScreenPlaylistInsideScreenOne extends StatelessWidget {
  final int currentplaylistindex;
  const ScreenPlaylistInsideScreenOne(
      {super.key, required this.currentplaylistindex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.height * 0.4,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: bgColor2, width: 3),
                image: const DecorationImage(
                  image: AssetImage('assets/image/mostly_img.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playListNotifier.value[currentplaylistindex].name,
                    style: GoogleFonts.inconsolata(
                        fontSize: 20, color: Colors.black),
                  ),
                  Text(
                    '${playListNotifier.value[currentplaylistindex].container.length} songs',
                    style: GoogleFonts.inconsolata(color: Colors.black),
                  ),
                ],
              ),
              playListNotifier.value[currentplaylistindex].container.isEmpty
                  ? const SizedBox()
                  : InkWell(
                      onTap: () {
                        playAudio(
                          playListNotifier
                              .value[currentplaylistindex].container,
                          0,
                        );
                      },
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundColor: bgColor2,
                        child: Icon(
                          Icons.play_arrow_rounded,
                          size: 50,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
