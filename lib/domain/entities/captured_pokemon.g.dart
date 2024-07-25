// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captured_pokemon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CapturedPokemonAdapter extends TypeAdapter<CapturedPokemon> {
  @override
  final int typeId = 0;

  @override
  CapturedPokemon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CapturedPokemon(
      pokemonId: fields[0] as int,
      name: fields[1] as String,
      imageUrl: fields[2] as String,
      height: fields[3] as int,
      weight: fields[4] as int,
      types: (fields[5] as List).cast<String>(),
      abilities: (fields[6] as List).cast<String>(),
      baseExperience: fields[7] as int,
      stats: (fields[8] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, CapturedPokemon obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.pokemonId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.weight)
      ..writeByte(5)
      ..write(obj.types)
      ..writeByte(6)
      ..write(obj.abilities)
      ..writeByte(7)
      ..write(obj.baseExperience)
      ..writeByte(8)
      ..write(obj.stats);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CapturedPokemonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
