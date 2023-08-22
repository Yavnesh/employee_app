// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeEntityAdapter extends TypeAdapter<EmployeeEntity> {
  @override
  final int typeId = 0;

  @override
  EmployeeEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeEntity(
      id: fields[0] as String?,
      name: fields[1] as String,
      designation: fields[2] as String,
      startDate: fields[3] as DateTime,
      endDate: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.designation)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
