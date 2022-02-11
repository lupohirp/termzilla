// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termzilla.connectioninfo.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConnectionInfoAdapter extends TypeAdapter<ConnectionInfo> {
  @override
  final int typeId = 1;

  @override
  ConnectionInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConnectionInfo()
      ..nameOfTheConnection = fields[0] as String
      ..ipAddress = fields[1] as String
      ..port = fields[2] as String
      ..username = fields[3] as String
      ..password = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, ConnectionInfo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.nameOfTheConnection)
      ..writeByte(1)
      ..write(obj.ipAddress)
      ..writeByte(2)
      ..write(obj.port)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConnectionInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
