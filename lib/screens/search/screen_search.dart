import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:stargazer_app/functions/song_fetch.dart';
import 'package:stargazer_app/screens/playlist/playlist_add.dart';
import 'package:stargazer_app/screens/songs/widgets/now_playing.dart';
import 'package:stargazer_app/screens/widgets/fav_icon.dart';

import '../../constants/const.dart';
import '../../model/song_model.dart';
import '../songs/widgets/custom_songs_listtile.dart';

class ScreenSearchSong extends StatefulWidget {
  const ScreenSearchSong({super.key});

  @override
  State<ScreenSearchSong> createState() => _ScreenSearchSongState();
}

class _ScreenSearchSongState extends State<ScreenSearchSong> {
  final controller = TextEditingController();
  List<AllSongModel> songList = allsongsList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/image/Stargazer_logo.png'),
          radius: 34,
        ),
        backgroundColor: bgColor,
      ),
      backgroundColor: bgColor,
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintStyle: GoogleFonts.inconsolata(),
                filled: true,
                fillColor: bgColor2,
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    _onTextChanged("");
                  },
                ),
                hintText: 'Songs, artist or album',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: bgColor2),
                ),
              ),
              onChanged: _onTextChanged,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: songList.length,
              itemBuilder: (context, index) {
                final song = songList[index];

                return GestureDetector(
                  child: StarGazerListTile(
                    index: index,
                    context: context,
                    leading: QueryArtworkWidget(
                      id: song.id,
                      type: ArtworkType.AUDIO,
                      controller: audioQuery,
                      nullArtworkWidget: const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/image/microphone_img.jpg'),
                      ),
                    ),
                    title: Text(
                      song.title,
                      style: GoogleFonts.inconsolata(),
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      song.artist == "<unknown>"
                          ? "Artist Unknown"
                          : song.artist,
                      style: GoogleFonts.inconsolata(),
                      maxLines: 1,
                    ),
                    trailFavIcon: FavIcon(
                        currentSong: songList[index], isFavorite: false),
                    trailListIcon: IconButton(
                      onPressed: () {
                        // showAddToPlaylistDialog(index);
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
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScreenNowPlaying(
                        index: index,
                        context: context,
                        allSongsList: songList,
                      ),
                    ));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onTextChanged(String query) {
    final suggestions = allsongsList.where(
      (song) {
        final songTitle = song.title.toLowerCase();
        final input = query.toLowerCase();

        return songTitle.contains(input);
      },
    ).toList();

    setState(() {
      songList = suggestions;
    });
  }
}
