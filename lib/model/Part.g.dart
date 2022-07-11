// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Part.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PartAdapter extends TypeAdapter<Part> {
  @override
  final int typeId = 3;

  @override
  Part read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Part(
      (fields[0] as List?)?.cast<Kangi>(),
    )
      ..complete = fields[1] as bool
      ..last_index = fields[2] as int
      ..restKangis = (fields[3] as List).cast<Kangi>();
  }

  @override
  void write(BinaryWriter writer, Part obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.kangis)
      ..writeByte(1)
      ..write(obj.complete)
      ..writeByte(2)
      ..write(obj.last_index)
      ..writeByte(3)
      ..write(obj.restKangis);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
