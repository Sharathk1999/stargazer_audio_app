import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:stargazer_app/constants/const.dart';
import 'package:stargazer_app/functions/song_fetch.dart';
import 'package:stargazer_app/screens/playlist/playlist_add.dart';
import 'package:stargazer_app/screens/playlist/screen_playlist.dart';
import 'package:stargazer_app/screens/playlist/widgets/playlist_inside_screen1.dart';
import 'package:stargazer_app/screens/playlist/widgets/playlist_inside_screen2.dart';
import 'package:stargazer_app/screens/songs/widgets/custom_songs_listtile.dart';
import 'package:stargazer_app/screens/widgets/fav_icon.dart';

class ScreenPlaylistInside extends StatelessWidget {
  final int currentplaylistindex;
  const ScreenPlaylistInside({super.key, required this.currentplaylistindex});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: bgColor),
          child: ValueListenableBuilder(
            valueListenable: playListNotifier,
            builder: (context, value, child) => Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              playListNotifier.notifyListeners();
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                backgroundColor: bgColor,
                                context: context,
                                builder: (context) =>
                                    bottomsheetallsongs(context),
                              );
                            },
                            icon: const Icon(
                              Icons.add_to_photos,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ScreenPlaylistInsideScreenOne(
                    currentplaylistindex: currentplaylistindex),
                playListNotifier.value[currentplaylistindex].container.isEmpty
                    ? const Expanded(
                        child: SizedBox(
                          child: Center(
                            child: Text(
                              'No songs in playlist, add songs',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      )
                    : ScreenPlaylistInsideScreenTwo(
                        currentplaylistindex: currentplaylistindex,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomsheetallsongs(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: allsongsList.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: StarGazerListTile(
                  index: index,
                  context: context,
                  leading: QueryArtworkWidget(
                    id: allsongsList[index].id,
                    type: ArtworkType.AUDIO,
                    controller: audioQuery,
                    nullArtworkWidget: const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/image/microphone_img.jpg'),
                    ),
                  ),
                  title: Text(
                    allsongsList[index].title,
                    style: GoogleFonts.inconsolata(),
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    allsongsList[index].artist == "<unknown>"
                        ? "Artist Unknown"
                        : allsongsList[index].artist,
                    style: GoogleFonts.inconsolata(),
                    maxLines: 1,
                  ),
                  trailFavIcon: FavIcon(
                      currentSong: allsongsList[index], isFavorite: false),
                  trailListIcon: IconButton(
                    onPressed: () {
                      // add to playlist function
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
          )
        ],
      ),
    );
  }
}
