import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:stargazer_app/model/song_model.dart';

class StarGazerMiniplayer extends StatelessWidget {
  final QueryArtworkWidget artworkWidget;
  final List<AllSongModel> allsongsList;
  final int index;
  final IconButton playBtn;
  final IconButton pauseBtn;
  final String title;
  final MiniMusicVisualizer miniviz;
  const StarGazerMiniplayer(
      {super.key,
      required this.artworkWidget,
      required this.allsongsList,
      required this.index,
      required this.playBtn,
      required this.pauseBtn,
      required this.title,
      required this.miniviz});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withAlpha(250)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            artworkWidget,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    title.split(' ')[0],
                    style: GoogleFonts.inconsolata(
                        color: Colors.black54, fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                  ),
                ),
              ],
            ),
            playBtn,
            pauseBtn,
            miniviz,
          ],
        ),
      ),
    );
  }
}
