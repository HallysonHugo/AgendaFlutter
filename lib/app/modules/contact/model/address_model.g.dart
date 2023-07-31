// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressModelAdapter extends TypeAdapter<AddressModel> {
  @override
  final int typeId = 2;

  @override
  AddressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddressModel()
      ..latitude = fields[0] as String
      ..longitude = fields[1] as String
      ..cep = fields[2] as String
      ..logradouro = fields[3] as String
      ..complemento = fields[4] as String
      ..bairro = fields[5] as String
      ..cidade = fields[6] as String
      ..uf = fields[7] as String;
  }

  @override
  void write(BinaryWriter writer, AddressModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.cep)
      ..writeByte(3)
      ..write(obj.logradouro)
      ..writeByte(4)
      ..write(obj.complemento)
      ..writeByte(5)
      ..write(obj.bairro)
      ..writeByte(6)
      ..write(obj.cidade)
      ..writeByte(7)
      ..write(obj.uf);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
