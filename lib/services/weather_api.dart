import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ciel/models/weather.dart';



class WeatherApi {
  static const apiKey = '49616494e78924aca40ff722d927fec8';


  static Future<Weather> fetchWeather(String cityName) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final main = data['main'];
      final temperature = main['temp'];
      final weatherCondition = data['weather'][0]['main'];

      return Weather(
        cityName: cityName,
        temperature: temperature,
        weatherCondition: weatherCondition,
      );
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
