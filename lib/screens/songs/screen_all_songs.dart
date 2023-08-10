import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:stargazer_app/functions/mostly_played.dart';
import 'package:stargazer_app/screens/mostly/screen_mostly.dart';
import 'package:stargazer_app/screens/playlist/playlist_add.dart';
import 'package:stargazer_app/screens/recently/screen_recently.dart';
import 'package:stargazer_app/screens/songs/screen_intro.dart';
import 'package:stargazer_app/screens/songs/widgets/custom_songs_listtile.dart';
import 'package:stargazer_app/screens/songs/widgets/customcard_widget.dart';
import 'package:stargazer_app/screens/songs/widgets/now_playing.dart';
import 'package:stargazer_app/screens/widgets/fav_icon.dart';
import 'package:stargazer_app/screens/widgets/miniplayer.dart';

import '../../constants/const.dart';
import '../../functions/get_permission.dart';
import '../../functions/song_fetch.dart';
import '../favorites/fav_screen.dart';
import '../playlist/screen_playlist.dart';

AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

int miniIndex = 0;

class ScreenAllSongs extends StatefulWidget {
  const ScreenAllSongs({Key? key}) : super(key: key);

  @override
  State<ScreenAllSongs> createState() => _ScreenAllSongsState();
}

class _ScreenAllSongsState extends State<ScreenAllSongs> {
  bool isVisible = false;
  @override
  void initState() {
    super.initState();
    fetchMostlyPlayed();
  }

  List<Audio> audioList = allsongsList.map((song) {
    return Audio(
      song.filePath, // Assuming filePath is the path to the audio file
      metas: Metas(
        title: song.title,
        artist: song.artist,
        // You can set other metadata fields here
      ),
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'StarGazer',
          style: GoogleFonts.aclonica(),
        ),
        backgroundColor: bgColor,
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/image/Stargazer_logo-bg.png'),
          backgroundColor: bgColor,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Playlist
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ScreenPlaylist(),
                              ));
                            },
                            child: const StarGazerCustomCard(
                              name: 'PlayList',
                              imgPath: 'assets/image/vinyl-player.jpg',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          //Recently played
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ScreenRecently(
                                  imgPath: 'assets/image/recently_img.jpg',
                                  name: 'Recently\nplayed',
                                ),
                              ));
                            },
                            child: const StarGazerCustomCard(
                              name: 'Recently\nplayed',
                              imgPath: 'assets/image/recently_img.jpg',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          //Favorites
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ScreenFavorite(),
                              ));
                            },
                            child: const StarGazerCustomCard(
                              name: 'Favorites',
                              imgPath: 'assets/image/favorites_img.jpg',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          //Mostly played
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ScreenMostly(),
                              ));
                            },
                            child: const StarGazerCustomCard(
                              name: 'Mostly\nPlayed',
                              imgPath: 'assets/image/mostly_img.jpg',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All Songs',
                          style: GoogleFonts.inconsolata(fontSize: 24),
                        ),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.bookOpen,
                              color: Colors.red.withAlpha(40),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ScreenIntro(),
                                    ));
                              },
                              child: Text(
                                'Quotes',
                                style: GoogleFonts.inconsolata(
                                    color: Colors.black54),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                !hasPermission
                    ? noAccessToLibraryWidget()
                    : allsongsList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
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
                                      backgroundImage: AssetImage(
                                          'assets/image/microphone_img.jpg'),
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
                                      currentSong: allsongsList[index],
                                      isFavorite: false),
                                  trailListIcon: IconButton(
                                    onPressed: () {
                                      // showAddToPlaylistDialog(index);
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
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
                                onTap: () {
                                  // playAudio(allsongsList, index);
                                  setState(() {
                                    isVisible = true;
                                    miniIndex = index;
                                  });
                                },
                              );
                            },
                          )
                        : const SizedBox(
                            width: 35,
                            height: 35,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
              ],
            ),
          ),
          Positioned(
              bottom: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                //miniPlayer
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ScreenNowPlaying(
                          allSongsList: allsongsList,
                          index: miniIndex,
                          context: context,
                          // assetsAudioPlayer: assetsAudioPlayer,
                        );
                      },
                    ));
                  },
                  child: Visibility(
                    visible: isVisible,
                    child: StarGazerMiniplayer(
                      artworkWidget: QueryArtworkWidget(
                        id: allsongsList[miniIndex].id,
                        type: ArtworkType.AUDIO,
                        size: 100,
                        nullArtworkWidget: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/image/favorites_img.jpg'),
                          radius: 25,
                        ),
                      ),
                      allsongsList: allsongsList,
                      index: miniIndex,
                      playBtn: IconButton(
                        onPressed: () {
                          assetsAudioPlayer.open(
                              Audio.file(allsongsList[miniIndex].filePath));
                          assetsAudioPlayer.play();
                        },
                        icon: const Icon(
                          FontAwesomeIcons.play,
                          size: 15,
                        ),
                      ),
                      pauseBtn: IconButton(
                        onPressed: () {
                          assetsAudioPlayer.pause();
                        },
                        icon: const Icon(
                          FontAwesomeIcons.pause,
                          size: 15,
                        ),
                      ),
                      title: allsongsList[miniIndex].title,
                      miniviz: const MiniMusicVisualizer(
                        width: 3,
                        height: 10,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget noAccessToLibraryWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.redAccent.withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Your App doesn't have access to the library",
            style: GoogleFonts.inconsolata(),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => checkAndRequestPermissions(retry: true),
            child: Text(
              "Allow",
              style: GoogleFonts.inconsolata(),
            ),
          ),
        ],
      ),
    );
  }
}
