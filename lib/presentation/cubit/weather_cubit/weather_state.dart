import 'package:weather/weather.dart';

abstract class WeatherState {}

class WeatherInitState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherSuccessState extends WeatherState {
  Weather? weather;
  List<Weather>? listWeatherForecast;

  WeatherSuccessState({this.weather, this.listWeatherForecast});
}

class WeatherFailedState extends WeatherState {
  final String error;

  WeatherFailedState(this.error);
}
