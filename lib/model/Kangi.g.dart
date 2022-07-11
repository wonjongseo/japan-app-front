// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Kangi.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KangiAdapter extends TypeAdapter<Kangi> {
  @override
  final int typeId = 1;

  @override
  Kangi read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Kangi(
      japan: fields[0] as String,
      korea: fields[1] as String,
      undoc: fields[2] as String,
      hundoc: fields[3] as String,
      id: fields[4] as String,
      level: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Kangi obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.japan)
      ..writeByte(1)
      ..write(obj.korea)
      ..writeByte(2)
      ..write(obj.undoc)
      ..writeByte(3)
      ..write(obj.hundoc)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.level);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KangiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
