import 'package:hive_flutter/adapters.dart';

part 'fav_model.g.dart';

@HiveType(typeId: 1)
class FavModel extends HiveObject {
  @HiveField(0)
  int songId;

  FavModel({required this.songId});
}
