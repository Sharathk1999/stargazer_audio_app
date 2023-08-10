import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:stargazer_app/constants/const.dart';
import 'package:stargazer_app/functions/recently_function.dart';
import 'package:stargazer_app/functions/song_fetch.dart';
import 'package:stargazer_app/screens/playlist/playlist_add.dart';
import 'package:stargazer_app/screens/songs/widgets/custom_songs_listtile.dart';
import 'package:stargazer_app/screens/songs/widgets/now_playing.dart';
import 'package:stargazer_app/screens/widgets/custom_style_container.dart';
import 'package:stargazer_app/screens/widgets/fav_icon.dart';

class ScreenRecently extends StatefulWidget {
  const ScreenRecently({super.key, required this.name, required this.imgPath});
  final String name;
  final String imgPath;

  @override
  State<ScreenRecently> createState() => _ScreenRecentlyState();
}

class _ScreenRecentlyState extends State<ScreenRecently> {
  @override
  void initState() {
    super.initState();
    recentListfetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                  vertical: MediaQuery.of(context).size.height * 0.04),
              child: StarGazerCustomStyleContainer(
                imgPath: widget.imgPath,
                name: widget.name,
              ),
            ),
            Expanded(
              child: recentListView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget recentListView() {
    if (recentList.value.isEmpty) {
      return  Center(
        child: Text(
          'No Recent Items',
          style: GoogleFonts.inconsolata(fontSize: 18,fontWeight: FontWeight.w500),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ScreenNowPlaying(
                      index: index,
                      context: context,
                      allSongsList: recentList.value),
                ),
              );
            },
            child: StarGazerListTile(
              index: index,
              context: context,
              leading: QueryArtworkWidget(
                id: recentList.value[index].id,
                type: ArtworkType.AUDIO,
                controller: audioQuery,
                nullArtworkWidget: const CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/image/microphone_img.jpg'),
                ),
              ),
              title: Text(
                recentList.value[index].title,
                style: GoogleFonts.inconsolata(),
                maxLines: 1,
              ),
              subtitle: Text(
                recentList.value[index].artist == "<unknown>"
                    ? "Artist Unknown"
                    : recentList.value[index].artist,
                style: GoogleFonts.inconsolata(),
                maxLines: 1,
              ),
              trailFavIcon: FavIcon(
                  currentSong: recentList.value[index], isFavorite: false),
              trailListIcon: IconButton(
                onPressed: () {
                  // add
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return AddToPlaylist(
                        addingsong: allsongsList[index],
                      );
                    },
                  ));
                },
                icon: const Icon(Icons.library_music_sharp),
              ),
            ),
          );
        },
        itemCount: recentList.value.length,
      ),
    );
  }
}
