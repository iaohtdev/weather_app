import 'package:weather/weather.dart';
import 'package:weather_app/constant.dart';
import 'package:weather_app/shared/helper/log_helper.dart';

class WeatherRepository {
  Future fetchWeather(
      {double? lat, double? long, Function? onCompeleted}) async {
    try {
      WeatherFactory weatherFactory =
          WeatherFactory(AppConstant.OPEN_WEATHER_KEY);

      Weather weather =
          await weatherFactory.currentWeatherByLocation(lat ?? 0.0, long ?? 00);

      onCompeleted!(weather);
      return weather;
    } catch (e) {
      LogHelper.error(e);
    }
  }

  Future fetchLstWeatherForecast(
      {double? lat, double? long, Function? onCompeleted}) async {
    try {
      WeatherFactory weatherFactory =
          WeatherFactory(AppConstant.OPEN_WEATHER_KEY);

      List<Weather> listWeatherForecast = await weatherFactory
          .fiveDayForecastByLocation(lat ?? 0.0, long ?? 00);

      onCompeleted!(listWeatherForecast);
      return listWeatherForecast;
    } catch (e) {
      LogHelper.error(e);
    }
  }

  Future fetchWeatherByCity({
    required String city,
    Function? onCompeleted,
    Function? onError,
  }) async {
    try {
      WeatherFactory weatherFactory =
          WeatherFactory(AppConstant.OPEN_WEATHER_KEY);

      Weather weather = await weatherFactory.currentWeatherByCityName(city);

      onCompeleted!(weather);
      return weather;
    } catch (e) {
      onError!(e);
      LogHelper.error(e);
    }
  }
}
