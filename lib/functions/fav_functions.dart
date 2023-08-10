import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stargazer_app/functions/song_fetch.dart';
import 'package:stargazer_app/model/fav_model.dart';
import 'package:stargazer_app/model/song_model.dart';

ValueNotifier<List<AllSongModel>> favoriteList = ValueNotifier([]);

Future<void> addToFavorite(AllSongModel songs) async {
  favoriteList.value.insert(0, songs);
  Box<FavModel> favDB = await Hive.openBox<FavModel>('favorite_db');
  FavModel temp = FavModel(songId: songs.id);
  await favDB.add(temp);
  favoriteList.notifyListeners();
  getFavorite();
}

getFavorite() async {
  favoriteList.value.clear();
  List<FavModel> favSongCheck = [];
  final favDb = await Hive.openBox<FavModel>('favorite_db');
  favSongCheck.addAll(favDb.values);
  for (var favs in favSongCheck) {
    int count = 0;
    for (var songs in allsongsList) {
      if (favs.songId == songs.id) {
        favoriteList.value.add(songs);
        break;
      } else {
        count++;
      }
    }
    if (count == allsongsList.length) {
      var key = favs.key;
      favDb.delete(key);
    }
  }
  favoriteList.notifyListeners();
}

removeFavorite(AllSongModel song) async {
  favoriteList.value.remove(song);
  List<FavModel> templist = [];
  Box<FavModel> favdb = await Hive.openBox('favorite_db');
  templist.addAll(favdb.values);
  for (var element in templist) {
    if (element.songId == song.id) {
      var key = element.key;
      favdb.delete(key);
      break;
    }
  }
  favoriteList.notifyListeners();
  getFavorite();
}
