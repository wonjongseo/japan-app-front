// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Progressing.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProgressingAdapter extends TypeAdapter<Progressing> {
  @override
  final int typeId = 0;

  @override
  Progressing read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Progressing()
      ..step = (fields[1] as List).cast<int>()
      ..is_level_complete = fields[2] as bool
      ..is_step_complete = (fields[4] as List).cast<bool>();
  }

  @override
  void write(BinaryWriter writer, Progressing obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.step)
      ..writeByte(2)
      ..write(obj.is_level_complete)
      ..writeByte(4)
      ..write(obj.is_step_complete);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
