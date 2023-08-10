import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:stargazer_app/functions/fav_functions.dart';
import 'package:stargazer_app/functions/song_fetch.dart';
import 'package:stargazer_app/screens/playlist/playlist_add.dart';
import 'package:stargazer_app/screens/songs/widgets/now_playing.dart';
import 'package:stargazer_app/screens/widgets/fav_icon.dart';

import '../../constants/const.dart';
import '../songs/widgets/custom_songs_listtile.dart';
import '../widgets/custom_style_container.dart';

class ScreenFavorite extends StatefulWidget {
  const ScreenFavorite({super.key});

  @override
  State<ScreenFavorite> createState() => _ScreenFavoriteState();
}

class _ScreenFavoriteState extends State<ScreenFavorite> {
  @override
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
        children: [
          // Fav custom container
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 17),
            child: StarGazerCustomStyleContainer(
              name: 'Favorites',
              imgPath: 'assets/image/favorites_img.jpg',
            ),
          ),
          // checks if favList is empty
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: favoriteList,
                    builder: (context, value, child) {
                      return favoriteList.value.isEmpty
                          ? songEmptyMessageWidget()
                          : favoriteListCustomWidet();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget songEmptyMessageWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 130),
      child: Center(
        child: Text(
          'Not favorites yet buddy😍',
          style: GoogleFonts.inconsolata(color: Colors.black87),
        ),
      ),
    );
  }

  Widget favoriteListCustomWidet() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: favoriteList.value.length,
      itemBuilder: (context, index) {
        //checkIsFavorite() checks for song id
        return
            //StarGazerListTile() custom listTile to display songs
            InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ScreenNowPlaying(
                index: index,
                context: context,
                allSongsList: favoriteList.value,
              ),
            ));
          },
          child: StarGazerListTile(
            index: index,
            context: context,
            //QueryArtworkWidget() display artwork image
            leading: QueryArtworkWidget(
              id: favoriteList.value[index].id,
              type: ArtworkType.AUDIO,
              controller: audioQuery,
              nullArtworkWidget: const CircleAvatar(
                backgroundImage: AssetImage('assets/image/microphone_img.jpg'),
              ),
            ),
            //Display song title
            title: Text(
              favoriteList.value[index].title,
              style: GoogleFonts.inconsolata(),
              maxLines: 1,
            ),
            //Display artist name
            subtitle: Text(
              favoriteList.value[index].artist == "<unknown>"
                  ? "Artist Unknown"
                  : favoriteList.value[index].artist,
              style: GoogleFonts.inconsolata(),
              maxLines: 1,
            ),
            //Add to fav icon
            trailFavIcon: FavIcon(
                currentSong: favoriteList.value[index], isFavorite: true),
            //Add to playlist
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
    );
  }
}
