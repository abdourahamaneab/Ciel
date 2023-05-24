
import 'dart:async';
import 'package:ciel/models/weather.dart';
import 'package:ciel/services/weather_api.dart';
import 'package:flutter/material.dart';

class Affiche extends StatefulWidget {
  @override
  _Affiche createState() => _Affiche();
}

class _Affiche extends State<Affiche> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  int _messageIndex = 0;
  bool _animationComplete = false;
  late Future<List<Weather>> weatherData;

  List<String> _messages = [
    'Nous téléchargeons les données...',
    'C\'est presque fini...',
    'Plus que quelques secondes avant d\'avoir le résultat...',
  ];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 25),
    );

    _progressAnimation = Tween<double>(begin: 0, end: 100).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _animationComplete = true;
          });
        }
      });

    weatherData = fetchWeatherForCities(['Paris', 'Niamey', 'Dakar', 'Quebec', 'Moscou']);

    _startAnimation();

    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (!_animationComplete) {
        setState(() {
          _messageIndex = (_messageIndex + 1) % _messages.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startAnimation() {
    _animationComplete = false;
    _animationController.reset();
    _animationController.forward();
  }

  Future<List<Weather>> fetchWeatherForCities(List<String> cityNames) {
    WeatherApi weatherApi = WeatherApi();
    return Future.delayed(Duration(seconds: 21), () => weatherApi.fetchWeatherForCities(cityNames));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ciel',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        heightFactor: 1.5,
        child: FutureBuilder<List<Weather>>(
          future: weatherData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final weatherList = snapshot.data!;
              return Column(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    itemCount: weatherList.length,
                    itemBuilder: (context, index) {
                      final weather = weatherList[index];
                      return ListTile(
                        title: Text(
                          weather.cityName,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          weather.temperature.toString() + '°C',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        trailing: Text(
                          weather.weatherCondition,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        minLeadingWidth: 5,
                        minVerticalPadding: 20,
                      );
                    },
                  ),

                  Text(
                    _animationComplete ? 'Terminé' : _messages[_messageIndex],
                    style: TextStyle(fontSize: 17 ,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,


                  ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                  '${_progressAnimation.value.toInt()}%',
                  style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),

                  LinearProgressIndicator(
                    value: _progressAnimation.value / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () {
                      weatherData.then((weatherList) {
                        weatherList.forEach((weather) {
                          print('${weather.cityName} - ${weather.temperature} - ${weather.weatherCondition}');
                        });
                      });
                      _startAnimation();
                      setState(() {
                        weatherData = fetchWeatherForCities(['Paris', 'Niamey', 'Dakar', 'Quebec', 'Moscou']);
                      });
                    },
                    child: Icon(Icons.refresh),
                  ),



                ],
              );
            } else if (snapshot.hasError) {
              return Text('Erreur lors de la récupération des données météorologiques');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  const SizedBox(height: 20),
                  Text(
                    _animationComplete ? 'Terminé' : _messages[_messageIndex],
                    style: TextStyle(fontSize: 17),

                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: _progressAnimation.value / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${_progressAnimation.value.toInt()}%',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
