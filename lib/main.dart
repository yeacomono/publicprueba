// imports framework
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:get_it/get_it.dart';
//imports packages
import 'package:tennis_court_agend/Config/config.dart';
import 'package:tennis_court_agend/Models/courts_tennis.dart';
import 'package:tennis_court_agend/Pages/Home/Blocs/scheduled/agends_bloc.dart';
import 'package:tennis_court_agend/Pages/Initial/initial.dart';

void main() {
  setupLocator();
  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AgendsBloc()),
      ],
      child: const MyApp(),
    );
  }
}

// initialize the locator service
void setupLocator() {
  GetIt.I.registerSingleton<LocalStorage>(LocalStorage('db_location.json'));
  GetIt.I.registerSingleton<AgendsBloc>(AgendsBloc());
  GetIt.I.registerSingleton<CourtTennis>(
    CourtTennis(
        city: "Tenisfalsa",
        direction: "Calle del Deuce 123",
        name: "Cancha Ace Magnífico",
        state: "1"),
    instanceName: 'A',
  );
  GetIt.I.registerSingleton<CourtTennis>(
    CourtTennis(
        city: "Imaginario",
        direction: "Avenida Raqueta Este",
        name: "Espacio de Raquetas Élite",
        state: "2"),
    instanceName: 'B',
  );
  GetIt.I.registerSingleton<CourtTennis>(
    CourtTennis(
        city: "Villa del Golpe Ficticio",
        direction: "Carrera del Smash 456",
        name: "Territorio del Set Perfecto",
        state: "3"),
    instanceName: 'C',
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agend Tennis',
      initialRoute: InitialPage.routeName,
      routes: Routes.routes,
    );
  }
}
