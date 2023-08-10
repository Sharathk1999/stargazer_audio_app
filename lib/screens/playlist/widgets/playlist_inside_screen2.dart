import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:stargazer_app/functions/song_fetch.dart';
import 'package:stargazer_app/model/playlist.dart';
import 'package:stargazer_app/screens/playlist/playlist_add.dart';
import 'package:stargazer_app/screens/playlist/screen_playlist.dart';
import 'package:stargazer_app/screens/songs/widgets/custom_songs_listtile.dart';
import 'package:stargazer_app/screens/songs/widgets/now_playing.dart';
import 'package:stargazer_app/screens/widgets/fav_icon.dart';

class ScreenPlaylistInsideScreenTwo extends StatelessWidget {
  final int currentplaylistindex;
  const ScreenPlaylistInsideScreenTwo(
      {super.key, required this.currentplaylistindex});

  @override
  Widget build(BuildContext context) {
    final playlist = playListNotifier.value[currentplaylistindex];
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: InkWell(
              onTap: () {
                playAudio(
                  playListNotifier.value[currentplaylistindex].container,
                  index,
                );
            
              },
              child: listtile(context, index, playlist),
            ),
          ),
          itemCount:
              (playListNotifier.value[currentplaylistindex].container).length,
        ),
      ),
    );
  }

  Widget listtile(BuildContext context, int index, EachPlaylist playlist) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ScreenNowPlaying(index: index, context: context, allSongsList: playlist.container);
        },));
      
      },
      child: StarGazerListTile(
        index: index,
        context: context,
        leading: QueryArtworkWidget(
          id: playlist.container[index].id,
          type: ArtworkType.AUDIO,
          controller: OnAudioQuery(),
          nullArtworkWidget: const CircleAvatar(
            backgroundImage: AssetImage('assets/image/mostly_img.jpg'),
          ),
        ),
        title: Text(
          playlist.container[index].title,
          style: GoogleFonts.inconsolata(),
          maxLines: 1,
        ),
        subtitle: Text(
          playlist.container[index].artist == "<unknown>"
              ? "Artist Unknown"
              : playlist.container[index].artist,
          style: GoogleFonts.inconsolata(),
          maxLines: 1,
        ),
        trailFavIcon:
            FavIcon(currentSong: playlist.container[index], isFavorite: false),
        trailListIcon: IconButton(
          onPressed: () {
             // showAddToPlaylistDialog(index);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return AddToPlaylist(
                        addingsong: playlist.container[index],
                      );
                    },
                  ));
          },
          icon: const Icon(Icons.library_music_sharp),
        ),
      ),
    );
  }
}
