// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavModelAdapter extends TypeAdapter<FavModel> {
  @override
  final int typeId = 1;

  @override
  FavModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavModel(
      songId: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FavModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.songId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
