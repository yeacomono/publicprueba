// imports framework
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
// imports packages
import 'package:tennis_court_agend/Models/courts_tennis.dart';
import 'package:tennis_court_agend/Pages/Agend/Services/agend_service.dart';
import 'package:tennis_court_agend/Pages/Agend/Widgets/courts_select.dart';
import 'package:tennis_court_agend/Pages/Agend/Widgets/horario_selector.dart';
import 'package:tennis_court_agend/Pages/Home/Blocs/scheduled/agends_bloc.dart';
import 'package:tennis_court_agend/Styles/colors.dart';

class ReserverCourt extends StatefulWidget {
  static const String routeName = 'reserverCourt';
  const ReserverCourt({super.key});

  @override
  State<ReserverCourt> createState() => _ReserverCourtState();
}

class _ReserverCourtState extends State<ReserverCourt> {
  // controller of inputs
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  // state var probability rain
  num _rainProbability = 0.0;
  // get multiple singlen instances of CourtTennis
  var court = GetIt.I<CourtTennis>(instanceName: 'A');
  // select turn hour
  var select = Horario.Manana;
  // select of date picker date time
  DateTime? _selectedDate;
  // state loading
  bool _loading = false;

  // select of date picker date time
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != _selectedDate) {
      setState(
        () {
          _selectedDate = picked;
          _dateController.text = _selectedDate.toString().split(" ")[0];
          _loading = true;
        },
      );
      _rainProbability = await _getRainProbabilityForDate(picked);
      setState(() {
        _loading = false;
      });
    }
  }

  // request API of obtain probability of the rain
  Future<num> _getRainProbabilityForDate(DateTime date) async {
    final resp = await AgendService.obtainprecipitation(time: date);
    final probabilitylist = resp['response'] as List;
    if (kDebugMode) {
      print(probabilitylist.toString());
    }
    var resultprobability = 0.0;
    for (var item in probabilitylist) {
      resultprobability = resultprobability + item;
    }
    return resultprobability / probabilitylist.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserved Tennis Court'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Who is reserving this court?'),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Do you have a preferred day for the reservation?',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(88, 23, 89, 103),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () => _selectDate(context),
                          icon: const Icon(
                            Icons.calendar_month_outlined,
                            color: StylesColors.backgroundColor,
                            size: 35,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          enabled: false,
                          controller: _dateController,
                          keyboardType: TextInputType.none,
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              Row(
                children: [
                  _selectedDate != null
                      ? const Text('Chance of rainy day')
                      : Container(),
                  const SizedBox(
                    height: 20,
                    width: 10,
                  ),
                  const Icon(Icons.water_drop_outlined,
                      color: StylesColors.accentColor),
                  Visibility(
                    visible: !_loading,
                    child: Text('$_rainProbability%'),
                  ),
                  Visibility(
                    visible: _loading,
                    child: const SizedBox(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          color: StylesColors.backgroundColor,
                          strokeWidth: 3,
                        )),
                  )
                ],
              ),
              const Divider(),
              SizedBox(
                child: TennisCourtReservation(
                  onSelect: (String value) => court = GetIt.I<CourtTennis>(
                    instanceName: value,
                  ),
                ),
              ),
              SizedBox(
                height: 80,
                child: HorarioSelector(
                  selectCallback: (value) => select = value,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: StylesColors.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async => await reservedbuttonprocess(),
                child: const SizedBox(
                  width: 350,
                  child: Text(
                    'Reserve',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // execute event reserved button
  Future<void> reservedbuttonprocess() async {
    if (!validateFields()) return;
    final bloc = context.read<AgendsBloc>();

    final validatecourts = await bloc.validatecourts(
      _selectedDate ?? DateTime.now(),
      select,
      court.name ?? '',
      context,
    );

    if (validatecourts) return;
    final reserved = AgendCourtTennis(
      courtTennis: court,
      dateTime: _selectedDate,
      drop: _rainProbability.toString(),
      username: _nameController.text,
      type: select.name,
    );

    if (mounted) {
      bloc.add(RegisterAgends(agendCourtTennis: reserved));
      bloc.add(const ListItemAgens());
      Navigator.pop(context);
    }
  }

  // validate fields in the form
  bool validateFields() {
    if (_nameController.text.isEmpty) {
      _showSnackbar(
        context,
        message: "Write your name!",
      );
      return false;
    }
    if (_selectedDate == null) {
      _showSnackbar(
        context,
        message: "Select your day!",
      );
      return false;
    }
    if (_rainProbability == 0.0) {
      _showSnackbar(
        context,
        message: "View your probability rain !",
      );
      return false;
    }    
    return true;
  }

  // show snackbar with message alerts
  void _showSnackbar(BuildContext context, {String? message}) {
    final snackBar = SnackBar(
      content: Text(message ?? ''),
      duration: const Duration(milliseconds: 300),
      // action: SnackBarAction(
      //   // label: 'UNDO',
      //   onPressed: () {},
      // ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
