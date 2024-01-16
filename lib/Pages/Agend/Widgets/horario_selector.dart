// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:tennis_court_agend/Models/courts_tennis.dart';
import 'package:tennis_court_agend/Styles/colors.dart';

// Enum para los estados de horario

class HorarioSelector extends StatefulWidget {
  final Function(Horario value) selectCallback;
  const HorarioSelector({super.key, required this.selectCallback});

  @override
  // ignore: library_private_types_in_public_api
  _HorarioSelectorState createState() => _HorarioSelectorState();
}

class _HorarioSelectorState extends State<HorarioSelector> {
  // Estado actual del horario seleccionado
  Horario _horarioSeleccionado = Horario.Manana;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildHorarioContainer(Horario.Manana),
        const SizedBox(
          width: 20,
        ),
        _buildHorarioContainer(Horario.Tarde),
        const SizedBox(
          width: 20,
        ),
        _buildHorarioContainer(Horario.Noche),
      ],
    );
  }

  Widget _buildHorarioContainer(Horario horario) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Actualiza el estado del horario seleccionado
          setState(() {
            _horarioSeleccionado = horario;
          });
          widget.selectCallback(_horarioSeleccionado);
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: _horarioSeleccionado == horario
                ?  StylesColors.backgroundColor
                : StylesColors.primaryColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            _getHorarioInicial(horario),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  String _getHorarioInicial(Horario horario) {
    switch (horario) {
      case Horario.Manana:
        return 'Morning';
      case Horario.Tarde:
        return 'Afternoon';
      case Horario.Noche:
        return 'Evening';
    }
  }
}
