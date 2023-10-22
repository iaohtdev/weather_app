import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/data/respository/weather_repo.dart';

part 'search_cubit_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  final weatherRepository = WeatherRepository();

  void searchWeatherByCity(String city) {
    try {
      emit(SearchLoadingState());
      weatherRepository.fetchWeatherByCity(
          city: city,
          onCompeleted: (value) {
            emit(SearchSuccessState(weather: value));
          },
          onError: (e) {
            emit(SearchFailedState(e.toString()));
          });
    } catch (e) {
      emit(SearchFailedState(e.toString()));
    }
  }
}
