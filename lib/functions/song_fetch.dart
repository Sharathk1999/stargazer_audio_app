import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:stargazer_app/functions/fav_functions.dart';
import 'package:stargazer_app/functions/mostly_played.dart';
import 'package:stargazer_app/functions/recently_function.dart';
import 'package:stargazer_app/model/playlist.dart';
import 'package:stargazer_app/model/playlist_model.dart';
import 'package:stargazer_app/screens/playlist/screen_playlist.dart';

import '../constants/const.dart';
import '../model/song_model.dart';

AllSongModel? currentIndex;
List<AllSongModel> allsongsList = [];
List<Audio> playSongList = [];

Future<void> fetchSongFromDevice() async {
  try {
    List<SongModel> songs = await audioQuery.querySongs(
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    for (var songModel in songs) {
      AllSongModel allSongModel = AllSongModel(
        id: songModel.id,
        title: songModel.title,
        artist: songModel.artist.toString(),
        album: songModel.album.toString(),
        duration: songModel.duration!,
        filePath: songModel.uri!,
      );

      allsongsList.add(allSongModel);
    }
  } catch (e) {
    log(e.toString());
  }
  await playlistfetch();
  await getFavorite();
  await recentListfetch();
  await fetchMostlyPlayed();
  await fetchMostlyPlayed();
}

void playAudio(List<AllSongModel> playingList, int index) {
  List<Audio> playSongList = [];

  for (var i = 0; i < playingList.length; i++) {
    playSongList.add(Audio.file(
      playingList[i].filePath,
      metas: Metas(
        album: playingList[i].album,
        id: playingList[i].id.toString(),
        artist: playingList[i].artist,
        title: playingList[i].title,
      ),
    ));
  }

  assetsAudioPlayer.open(
    Playlist(audios: playSongList, startIndex: index),
    showNotification: true,
  );

  assetsAudioPlayer.setLoopMode(LoopMode.playlist);

  assetsAudioPlayer.play();
}

currentlyPlayingFinder(int? playingId) {
  for (AllSongModel song in allsongsList) {
    if (song.id == playingId) {
      currentlyplaying = song;
      break;
    }
  }
  addRecentList(currentlyplaying!);
}

playlistfetch() async {
  Box<PlayListModel> playlistdb = await Hive.openBox('playlist_db');
  for (PlayListModel elements in playlistdb.values) {
    String playlistname = elements.playlistName!;
    EachPlaylist playlistfetch = EachPlaylist(name: playlistname);
    for (int id in elements.items) {
      for (AllSongModel songs in allsongsList) {
        if (id == songs.id) {
          playlistfetch.container.add(songs);
          break;
        }
      }
    }
    playListNotifier.value.add(playlistfetch);
  }
}
