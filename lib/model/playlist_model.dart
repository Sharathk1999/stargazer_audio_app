import 'package:hive_flutter/adapters.dart';

part 'playlist_model.g.dart';

@HiveType(typeId: 2)
class PlayListModel extends HiveObject {
  @HiveField(0)
  List<int> items = [];
  @HiveField(1)
  String? playlistName;

  PlayListModel({required this.playlistName});
}
