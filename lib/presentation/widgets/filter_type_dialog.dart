import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_flutter_app/config/theme/pokemon_type_colors.dart';

class FilterTypeDialog extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String> onTypeSelected;

  const FilterTypeDialog({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> types = [
      '', // No filter option
      'fire', 'water', 'grass', 'electric', 'ice', 'fighting', 'poison', 'ground', 'flying',
      'psychic', 'bug', 'rock', 'ghost', 'dragon', 'dark', 'steel', 'fairy'
    ];

    return AlertDialog(
      title: const Text('Seleccionar Tipo'),
      content: SingleChildScrollView(
        child: Column(
          children: types.map((type) {
            return RadioListTile<String>(
              title: Text(type.isEmpty ? 'No filtrar' : '${type[0].toUpperCase()}${type.substring(1)}'),
              value: type,
              groupValue: selectedType,
              onChanged: (value) {
                onTypeSelected(value!);
                context.pop();
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
