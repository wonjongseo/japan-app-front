// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Level.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LevelAdapter extends TypeAdapter<Level> {
  @override
  final int typeId = 2;

  @override
  Level read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Level(
      (fields[0] as List?)?.cast<Part>(),
      fields[1] as int?,
    )
      ..complete = fields[2] as bool
      ..lastIndex = fields[3] as int;
  }

  @override
  void write(BinaryWriter writer, Level obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.parts)
      ..writeByte(1)
      ..write(obj.totalCnt)
      ..writeByte(2)
      ..write(obj.complete)
      ..writeByte(3)
      ..write(obj.lastIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
