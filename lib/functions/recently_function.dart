import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stargazer_app/functions/song_fetch.dart';
import 'package:stargazer_app/model/song_model.dart';

ValueNotifier<List<AllSongModel>> recentList = ValueNotifier([]);

addRecentList(AllSongModel song) async {
  Box<int> recentDb = await Hive.openBox<int>('recent_db');
  List<int> temp = [];
  temp.addAll(recentDb.values);
  if (recentList.value.contains(song)) {
    recentList.value.remove(song);
    recentList.value.insert(0, song);
    for (int i = 0; i < temp.length; i++) {
      if (song.id == temp[i]) {
        recentDb.deleteAt(i);
        recentDb.add(song.id);
      }
    }
  } else {
    recentList.value.insert(0, song);
    recentDb.add(song.id);
    if (recentList.value.length > 10) {
      recentList.value.removeAt(10);
    }
  }

  // print(recentDb.length);
  // recentfetch();
  recentList.notifyListeners();
}

recentListfetch() async {
  Box<int> recentDb = await Hive.openBox('recent_db');

  for (int element in recentDb.values) {
    for (AllSongModel song in allsongsList) {
      if (element == song.id) {
        recentList.value.add(song);
        break;
      }
    }
  }
  log("recent songs list ${recentList.value.length}");
  recentList.notifyListeners();
}

AllSongModel? currentlyplaying;
currentPlayingfinder(int songId) {
  for (AllSongModel songs in allsongsList) {
    if (songs.id == songId) {
      currentlyplaying = songs;
    }
  }
  addRecentList(currentlyplaying!);
}
