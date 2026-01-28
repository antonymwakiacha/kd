// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idiom.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IdiomAdapter extends TypeAdapter<Idiom> {
  @override
  final int typeId = 1;

  @override
  Idiom read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Idiom(
      id: fields[0] as int,
      phrase: fields[1] as String,
      meaning: fields[2] as String,
      isBookmarked: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Idiom obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.phrase)
      ..writeByte(2)
      ..write(obj.meaning)
      ..writeByte(3)
      ..write(obj.isBookmarked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdiomAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
