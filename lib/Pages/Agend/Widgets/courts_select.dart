import 'package:flutter/material.dart';
import 'package:tennis_court_agend/Styles/colors.dart';

class TennisCourtReservation extends StatefulWidget {
  final Function(String) onSelect;
  const TennisCourtReservation({super.key, required this.onSelect});

  @override
  State<TennisCourtReservation> createState() => _TennisCourtReservationState();
}

class _TennisCourtReservationState extends State<TennisCourtReservation> {
  String? _selectedCourt = 'A';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select a Tennis Court:'),
        const SizedBox(height: 10),
        Column(
          children: [
            RadioListTile(
              activeColor: StylesColors.backgroundColor,
              title: const Text('Court A'),
              value: 'A',
              groupValue: _selectedCourt,
              onChanged: (value) {
                setState(() {
                  _selectedCourt = value;
                });
                widget.onSelect(_selectedCourt??'');
              },
              secondary: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://www.shutterstock.com/image-photo/new-outdoor-red-tennis-courts-600nw-2165713305.jpg',
                  width: 70,
                  height: 70,
                ),
              ),
            ),
            const SizedBox(height: 10),
            RadioListTile(
              title: const Text('Court B'),
              activeColor: StylesColors.backgroundColor,
              value: 'B',
              groupValue: _selectedCourt,
              onChanged: (value) {
                setState(() {
                  _selectedCourt = value;
                });
                 widget.onSelect(_selectedCourt??'');
              },
              secondary: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://www.shutterstock.com/image-photo/new-outdoor-red-tennis-courts-600nw-2165713305.jpg',
                  width: 70,
                  height: 70,
                ),
              ),
            ),
            const SizedBox(height: 10),
            RadioListTile(
              title: const Text('Court C'),
              activeColor: StylesColors.backgroundColor,
              value: 'C',
              groupValue: _selectedCourt,
              onChanged: (value) {
                setState(() {
                  _selectedCourt = value;
                });
                widget.onSelect(_selectedCourt??'');
              },
              secondary: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://www.shutterstock.com/image-photo/new-outdoor-red-tennis-courts-600nw-2165713305.jpg',
                  width: 70,
                  height: 70,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
