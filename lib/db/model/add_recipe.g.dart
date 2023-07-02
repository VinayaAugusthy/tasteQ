// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddAdapter extends TypeAdapter<Add> {
  @override
  final int typeId = 1;

  @override
  Add read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Add(
      image: fields[1] as String,
      name: fields[2] as String,
      duration: fields[3] as String,
      mealType: fields[4] as String,
      category: fields[5] as String,
      ingrediants: fields[6] as String,
      procedure: fields[7] as String,
      videoLink: fields[8] as String,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Add obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.mealType)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.ingrediants)
      ..writeByte(7)
      ..write(obj.procedure)
      ..writeByte(8)
      ..write(obj.videoLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
