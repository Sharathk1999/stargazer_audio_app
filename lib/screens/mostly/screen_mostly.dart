import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:stargazer_app/constants/const.dart';
import 'package:stargazer_app/functions/mostly_played.dart';
import 'package:stargazer_app/functions/song_fetch.dart';
import 'package:stargazer_app/screens/playlist/playlist_add.dart';
import 'package:stargazer_app/screens/songs/widgets/custom_songs_listtile.dart';
import 'package:stargazer_app/screens/songs/widgets/now_playing.dart';
import 'package:stargazer_app/screens/widgets/custom_style_container.dart';
import 'package:stargazer_app/screens/widgets/fav_icon.dart';

class ScreenMostly extends StatefulWidget {
  const ScreenMostly({Key? key}) : super(key: key);

  @override
  State<ScreenMostly> createState() => _ScreenMostlyState();
}

class _ScreenMostlyState extends State<ScreenMostly> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
      ),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: MediaQuery.of(context).size.height * 0.04,
              ),
              child: const StarGazerCustomStyleContainer(
                name: 'Mostly Played',
                imgPath: 'assets/image/mostly_img.jpg',
              ),
            ),
            Expanded(
              child:
                  mostlyPlayedListView(), // Call the function to display the list of mostly played songs
            ),
          ],
        ),
      ),
    );
  }

  Widget mostlyPlayedListView() {
    if (mostplayedNotifier.value.isEmpty) {
      return Center(
        child: Text(
          'No Songs in Mostly Played 😑',
          style: GoogleFonts.inconsolata(),
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
                      allSongsList: mostplayedNotifier.value),
                ),
              );
            },
            child: StarGazerListTile(
              index: index,
              context: context,
              leading: QueryArtworkWidget(
                id: mostplayedNotifier.value[index].id,
                type: ArtworkType.AUDIO,
                controller: audioQuery,
                nullArtworkWidget: const CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/image/microphone_img.jpg'),
                ),
              ),
              title: Text(
                mostplayedNotifier.value[index].title,
                style: GoogleFonts.inconsolata(),
                maxLines: 1,
              ),
              subtitle: Text(
                mostplayedNotifier.value[index].artist == "<unknown>"
                    ? "Artist Unknown"
                    : mostplayedNotifier.value[index].artist,
                style: GoogleFonts.inconsolata(),
                maxLines: 1,
              ),
              trailFavIcon: IconButton(
                onPressed: () {},
                icon: FavIcon(
                    currentSong: mostplayedNotifier.value[index],
                    isFavorite: false),
              ),
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
          );
        },
        itemCount: mostplayedNotifier.value.length > 12
            ? 12
            : mostplayedNotifier.value.length,
      ),
    );
  }
}
