import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stargazer_app/functions/song_fetch.dart';
import 'package:stargazer_app/model/song_model.dart';

ValueNotifier<List<AllSongModel>> mostplayedNotifier = ValueNotifier([]);

addMostlyPlayedSongToDb(int id) async {
  Box<int> mostplayeddb = await Hive.openBox('mostlyPlayed_db');
  int count = mostplayeddb.get(id)!;
  mostplayeddb.put(id, count + 1);
  await addMostlyPlayedToList();
}

addMostlyPlayedToList() async {
  Box<int> mostplayedDb = await Hive.openBox('mostlyPlayed_db');

  List<List<int>> mostplayedTempList = [];

  for (AllSongModel song in allsongsList) {
    int count = mostplayedDb.get(song.id) ?? 0;
    mostplayedTempList.add([song.id, count]);
  }

  for (int i = 0; i < mostplayedTempList.length - 1; i++) {
    for (int j = i; j < mostplayedTempList.length; j++) {
      if (mostplayedTempList[i][1] < mostplayedTempList[j][1]) {
        List<int> tempList = mostplayedTempList[i];
        mostplayedTempList[i] = mostplayedTempList[j];
        mostplayedTempList[j] = tempList;
      }
    }
  }

  List<List<int>> tempList = [];
  for (int i = 0; i < mostplayedTempList.length && i < 10; i++) {
    tempList.add(mostplayedTempList[i]);
  }

  mostplayedTempList = tempList;

  if (mostplayedNotifier.value.isNotEmpty) {
    mostplayedNotifier.value.clear();
  }

  for (List<int> element in mostplayedTempList) {
    for (AllSongModel song in allsongsList) {
      if (element[0] == song.id && element[1] > 3) {
        mostplayedNotifier.value.add(song);
      }
    }
  }

  mostplayedNotifier.notifyListeners();
}

fetchMostlyPlayed() async {
  Box<int> mostplayedDb = await Hive.openBox('mostlyPlayed_db');
  if (mostplayedDb.isEmpty) {
    for (AllSongModel song in allsongsList) {
      mostplayedDb.put(song.id, 0);
    }
  } else {
    List<List<int>> mostplayedTempList = [];
    for (AllSongModel song in allsongsList) {
      int count = mostplayedDb.get(song.id)!;
      mostplayedTempList.add([song.id, count]);
    }
    for (int i = 0; i < mostplayedTempList.length - 1; i++) {
      for (int j = i; j < mostplayedTempList.length; j++) {
        if (mostplayedTempList[i][1] < mostplayedTempList[j][1]) {
          List<int> tempList = mostplayedTempList[i];
          mostplayedTempList[i] = mostplayedTempList[j];
          mostplayedTempList[j] = tempList;
        }
      }
    }

    List<List<int>> tempList = [];
    for (int i = 0; i < mostplayedTempList.length && i < 10; i++) {
      tempList.add(mostplayedTempList[i]);
    }

    mostplayedTempList = tempList;
    for (List<int> element in mostplayedTempList) {
      for (AllSongModel song in allsongsList) {
        if (element[0] == song.id && element[1] > 3) {
          mostplayedNotifier.value.add(song);
        }
      }
    }
    mostplayedNotifier.notifyListeners();
  }
}
