import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_clean_architecture/features/weather/data/models/weather_model.dart';
import 'package:flutter_weather_clean_architecture/features/weather/domain/entities/weather.dart';

import '../../../../helpers/json/json_reader.dart';

void main() {
  const tWeatherModel = WeatherModel(
    cityName: 'Teresina',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const tWeather = Weather(
    cityName: 'Teresina',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  group('entidade', () {
    test(
      'deve ser uma subclasse de entidade meteorológica',
      () async {
        // assert
        final result = tWeatherModel.toEntity();
        expect(result, equals(tWeather));
      },
    );
  });

  group('from json', () {
    test(
      'deve retornar um modelo válido do json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          readJson('helpers/json/weather.json'),
        );

        // act
        final result = WeatherModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tWeatherModel));
      },
    );
  });

  group('to json', () {
    test(
      'deve retornar um json map contendo dados adequados',
      () async {
        // act
        final result = tWeatherModel.toJson();

        // assert
        final expectedJsonMap = {
          'weather': [
            {
              'main': 'Clouds',
              'description': 'few clouds',
              'icon': '02d',
            }
          ],
          'main': {
            'temp': 302.28,
            'pressure': 1009,
            'humidity': 70,
          },
          'name': 'Teresina',
        };
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
