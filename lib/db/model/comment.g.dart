// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentsAdapter extends TypeAdapter<Comments> {
  @override
  final int typeId = 2;

  @override
  Comments read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Comments(
      userName: fields[0] as String,
      comment: fields[1] as String,
      recipeName: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Comments obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.comment)
      ..writeByte(2)
      ..write(obj.recipeName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
