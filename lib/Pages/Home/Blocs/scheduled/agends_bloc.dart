import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tennis_court_agend/Models/courts_tennis.dart';

part 'agends_event.dart';
part 'agends_state.dart';

class AgendsBloc extends Bloc<AgendsEvent, AgendsState> {
  var localstorage = GetIt.I.get<LocalStorage>();
  List<AgendCourtTennis> dataList = [];
  AgendsBloc() : super(AgendsLoading()) {
    on<RegisterAgends>(
      (event, emit) async {
        emit(AgendsLoading());
        try {
          final restoredata = await loadStoredData();
          restoredata.add(event.agendCourtTennis);
          await localstorage.setItem(
            'data',
            jsonEncode(restoredata),
          );
        } catch (e) {
          if (kDebugMode) {
            print('This Exception on UnRegisterAgends $e');
          }
          emit(const AgendsError(message: "Ocurred error"));
        }
      },
    );

    on<UnRegisterAgends>(
      (event, emit) async {
        emit(AgendsLoading());
        try {
          final restoredata = await loadStoredData();
          restoredata.removeWhere(
            (data) {
              final localtime = data.dateTime?.day;
              final externaltime = event.dateTime.day;
              final comparedates = (localtime == externaltime);
              final localturn = data.type;
              final externalturn = event.type;
              final compareturns = (localturn == externalturn);
              if (comparedates && compareturns) return true;
              return false;
            },
          );
          localstorage.setItem('data', jsonEncode(restoredata));
        } catch (e) {
          if (kDebugMode) {
            print('This Exception on UnRegisterAgends $e');
          }
          emit(const AgendsError(message: "Ocurred error"));
        }
      },
    );
    on<ListItemAgens>(
      (event, emit) async {
        // estado loading
        emit(AgendsLoading());
        await Future.delayed(const Duration(seconds: 1));
        try {
          final items = await loadStoredData();
          emit(AgendsLoaded(agendas: items));
          return;
        } catch (e) {
          if (kDebugMode) {
            print('This Exception on UnRegisterAgends $e');
          }
          emit(const AgendsError(message: "Ocurred error"));
        }
      },
    );
  }

  Future<bool> validatecourts(
      DateTime time, Horario horario, String name, BuildContext context) async {
    final restoredata = await loadStoredData();
    var isReserved = false;
    final filternewlist = restoredata
        .where((v) => v.courtTennis?.name == name)
        .where((v) => v.dateTime?.day == time.day)
        .where((v) => v.type == horario.name)
        .toList();
    if (filternewlist.isNotEmpty) {
      isReserved = true;
      final snackBar = SnackBar(
        content: const Text('Este turno ya esta reservado!'),
        duration: const Duration(seconds: 1),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {},
        ),
      );
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return isReserved;
  }

  Future<List<AgendCourtTennis>> loadStoredData() async {
    await localstorage.ready;
    final storedData = localstorage.getItem('data');
    if (storedData != null) {
      dataList = List<AgendCourtTennis>.from((jsonDecode(storedData) as List)
          .map((data) => AgendCourtTennis.fromJson(data))
          .toList());
      if (kDebugMode) {
        for (var item in dataList) {
          log('This List Agend ${item.toJson()}');
          print(item.dateTime?.day.toString());
        }
      }
      return dataList;
    }
    return [];
  }
}
