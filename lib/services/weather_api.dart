import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ciel/models/weather.dart';

class WeatherApi {
  String apiKey = '49616494e78924aca40ff722d927fec8';

  Future<List<Weather>> fetchWeatherForCities(List<String> cityNames) async {
    final List<Weather> weatherList = [];

    for (String cityName in cityNames) {
      String url =
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final main = data['main'];
        final temperature = main['temp'];
        final weatherCondition = data['weather'][0]['main'];

        final weather = Weather(
          cityName: cityName,
          temperature: temperature.toDouble(),
          weatherCondition: weatherCondition,
        );

        weatherList.add(weather);
      } else {
        throw Exception('Failed to fetch weather data for $cityName');
      }
    }

    return weatherList;
  }
}
