import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

abstract class AgendService {
  static Future<Map<String, dynamic>> obtainprecipitation(
      {required DateTime time}) async {
    final dio = Dio();
    const url = 'https://my.meteoblue.com/packages/basic-1h_basic-day';
    const apiKey = '7ae8Mv6OImL04jwh';
    const format = 'json';
    final startDate = time.toString();
    final endDate = time.toString();
    try {
      final mapub = await _obtenerUbicacion();
      final response = await dio.get(
        url,
        queryParameters: {
          'apikey': apiKey,
          'lat': mapub['latitud'],
          'lon': mapub['longitud'],
          'format': format,
          'start_date': startDate,
          'end_date': endDate,
        },
      );
      return {
        'status':true,
        'response': response.data['data_day']['precipitation_probability'],
      };
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return {'status': false, 'error': '$e'};
    }
  }

  static Future<Map<String, String>> _obtenerUbicacion() async {
    Map<String, String> ubicacion = {};
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();

        ubicacion = {
          'latitud': position.latitude.toString(),
          'longitud': position.longitude.toString(),
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener la ubicación: $e');
      }
    }

    return ubicacion;
  }
}
