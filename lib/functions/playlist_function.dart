import 'package:hive_flutter/hive_flutter.dart';
import 'package:stargazer_app/model/playlist.dart';
import 'package:stargazer_app/model/playlist_model.dart';
import 'package:stargazer_app/model/song_model.dart';
import 'package:stargazer_app/screens/playlist/screen_playlist.dart';

Future createPlaylist(playlistName) async {
  playListNotifier.value.add(EachPlaylist(name: playlistName));
  Box<PlayListModel> playlistdb = await Hive.openBox('playlist_db');
  playlistdb.add(PlayListModel(playlistName: playlistName));
}

Future addPlayListToDb(AllSongModel songAdd, String playListName) async {
  Box<PlayListModel> playlistdb = await Hive.openBox('playlist_db');
  for (PlayListModel element in playlistdb.values) {
    if (element.playlistName == playListName) {
      var key = element.key;
      PlayListModel playListUpdated = PlayListModel(playlistName: playListName);
      playListUpdated.items.addAll(element.items);
      playListUpdated.items.add(songAdd.id);
      playlistdb.put(key, playListUpdated);
      break;
    }
  }
  playlistdb.close();
}

Future removePlaylistFromDb(
    AllSongModel songRemoved, String playListName) async {
  Box<PlayListModel> playlistdb = await Hive.openBox('playlist_db');
  for (PlayListModel element in playlistdb.values) {
    if (element.playlistName == playListName) {
      var key = element.key;
      PlayListModel playListUpdated = PlayListModel(playlistName: playListName);
      for (int item in element.items) {
        if (item == songRemoved.id) {
          continue;
        }
        playListUpdated.items.add(item);
      }
      playlistdb.put(key, playListUpdated);
      break;
    }
  }
  playListNotifier.notifyListeners();
}

Future deletePlaylist(int index) async {
  String playlistname = playListNotifier.value[index].name;
  Box<PlayListModel> playlistdb = await Hive.openBox('playlist_db');
  for (PlayListModel element in playlistdb.values) {
    if (element.playlistName == playlistname) {
      var key = element.key;
      playlistdb.delete(key);
      break;
    }
  }
  playListNotifier.value.removeAt(index);
  playListNotifier.notifyListeners();
}

Future renamePlaylist(int index, String newname) async {
  String playlistname = playListNotifier.value[index].name;
  Box<PlayListModel> playlistdb = await Hive.openBox('playlist_db');
  for (PlayListModel element in playlistdb.values) {
    if (element.playlistName == playlistname) {
      var key = element.key;
      element.playlistName = newname;
      playlistdb.put(key, element);
    }
  }
  playListNotifier.value[index].name = newname;
  playListNotifier.notifyListeners();
}
