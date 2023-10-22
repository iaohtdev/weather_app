import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/respository/weather_repo.dart';
import 'package:weather_app/presentation/cubit/weather_cubit/weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitState());
  final weatherRepository = WeatherRepository();

  void fetchWeather({double? lat, double? long}) async {
    try {
      emit(WeatherLoadingState());

      await weatherRepository.fetchWeather(
          lat: lat,
          long: long,
          onCompeleted: (value) async {
            await weatherRepository.fetchLstWeatherForecast(
                lat: lat,
                long: long,
                onCompeleted: (lst) {
                  emit(WeatherSuccessState(
                      weather: value, listWeatherForecast: lst));
                });
          });
    } catch (e) {
      emit(WeatherFailedState(e.toString()));
    }
  }
}
