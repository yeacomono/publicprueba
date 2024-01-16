import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_court_agend/Models/courts_tennis.dart';
import 'package:tennis_court_agend/Pages/Home/Blocs/scheduled/agends_bloc.dart';

class ItemAgendCourtTennis extends StatelessWidget {
  final AgendCourtTennis item;
  const ItemAgendCourtTennis({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: _buildImageCourtTennis(),
            ),
            Expanded(
              flex: 4,
              child: _informationCourtTennis(context, item),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCourtTennis() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        'https://www.shutterstock.com/image-photo/new-outdoor-red-tennis-courts-600nw-2165713305.jpg',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _informationCourtTennis(BuildContext context, AgendCourtTennis item) {
    return Column(
      children: [
        Text(
          item.courtTennis?.name ?? '',
          style: _textStyle(),
        ),
        Text(
          item.courtTennis?.city ?? '',
          style: _textStyle(
              size: 10, color: const Color.fromARGB(255, 117, 116, 116)),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(
                  Icons.person_outline_rounded,
                  color: Colors.orangeAccent,
                ),
                Expanded(
                  child: Text(
                    item.username ?? '',
                    textAlign: TextAlign.center,
                    style: _textStyle(),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.tune,
                  color: Colors.orangeAccent,
                ),
                Expanded(
                  child: Text(
                    item.type ?? '',
                    textAlign: TextAlign.center,
                    style: _textStyle(),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.water_drop_outlined,
                color: Colors.blueAccent,
              ),
              Text(("${item.drop?.split('.')[0] ?? ''}%")),
              const Icon(
                Icons.date_range_outlined,
                color: Colors.orangeAccent,
              ),
              Text(
                item.dateTime.toString().split(' ')[0],
                textAlign: TextAlign.center,
                style: _textStyle(),
              ),
              IconButton(
                onPressed: () {
                  final agendbloc = context.read<AgendsBloc>();
                  agendbloc.add(
                    UnRegisterAgends(
                      dateTime: item.dateTime ?? DateTime.now(),
                      type: item.type ?? '',
                    ),
                  );
                  agendbloc.add(const ListItemAgens());
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  TextStyle _textStyle({
    double? size,
    Color? color,
  }) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w700,
      fontSize: size,
      overflow: TextOverflow.ellipsis,
    );
  }

  /* 
  La lista debe mostrar el nombre de la cancha, la
  fecha y el nombre del usuario que realizó el agendamiento. También debe mostrar el
  porcentaje de probabilidad de lluvia para este día, más detalles luego. El elemento de la
  lista debe poseer un botón para borrar el agendamiento, al hacer clic debe mostrar un
  mensaje que confirme si desea borrar el agendamiento.  


e  "Cancha Ace Magnífico"
  "Espacio de Raquetas Élite"
  "Territorio del Set Perfecto"

  ChatGPT
  "Calle del Deuce 123, Ciudad Tenisfalsa"
  "Avenida Raqueta Este, Pueblo Imaginario"
  "Carrera del Smash 456, Villa del Golpe Ficticio"
  */
}
