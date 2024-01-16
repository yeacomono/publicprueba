import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:tennis_court_agend/Pages/Agend/Services/agend_service.dart';

class MockDio extends Mock implements Dio {}

class MockAgendService extends AgendService {
  MockAgendService({required Dio dio});
}

void main() {
  group('AgendService Test', () {
    late MockAgendService agendService;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      agendService = MockAgendService(dio: mockDio);
    });

    test('obtainprecipitation should return precipitation probability',
        () async {
      // Arrange
      final mockResponse = {
        'data_day': {'precipitation_probability': 0.5},
      };

      when(mockDio.get("", queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async =>
              Response(data: mockResponse, requestOptions: RequestOptions()));

      // Act
      final result =
          await AgendService.obtainprecipitation(time: DateTime.now());

      // Assert
      expect(result['status'], true);
      expect(result['response'], 0.5);
    });

    test('obtainprecipitation should handle errors', () async {
      // Arrange
      when(mockDio.get("", queryParameters: anyNamed('queryParameters')))
          .thenThrow(DioError(requestOptions: RequestOptions()));

      // Act
      final result =
          await AgendService.obtainprecipitation(time: DateTime.now());

      // Assert
      expect(result['status'], false);
      expect(result['error'], isNotNull);
    });
  });
}
