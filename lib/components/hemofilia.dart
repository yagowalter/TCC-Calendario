import 'package:flutter/material.dart';

class HemofiliaSelector extends StatefulWidget {
  final String? selectedValue;
  final void Function(String?) onChanged;

  const HemofiliaSelector({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  State<HemofiliaSelector> createState() => _HemofiliaSelectorState();
}

class _HemofiliaSelectorState extends State<HemofiliaSelector> {
  final List<String> hemofiliaTypes = ['Tipo A', 'Tipo B', ''];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: Container(),
      value: widget.selectedValue,
      onChanged: widget.onChanged,
      items: hemofiliaTypes.map((type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
    );
  }
}

class HemofiliaGravidade extends StatefulWidget {
  final String? value;
  final void Function(String?) onChange;

  const HemofiliaGravidade({
    super.key,
    required this.value,
    required this.onChange,
  });

  @override
  State<HemofiliaGravidade> createState() => _HemofiliaGravidadeState();
}

class _HemofiliaGravidadeState extends State<HemofiliaGravidade> {
  final List<String> hemofiliaGravidade = ['Leve', 'Moderado', 'Grave'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: Container(),
      value: widget.value,
      onChanged: widget.onChange,
      items: hemofiliaGravidade.map((type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
    );
  }
}
