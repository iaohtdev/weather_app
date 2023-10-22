import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/constant.dart';
import 'package:weather_app/presentation/screens/home/weekly_forecast/weekly_screen.dart';
import 'package:weather_app/shared/common.dart';
import 'package:weather_app/shared/helper/image_helper.dart';

class WeatherForecastWidget extends StatefulWidget {
  const WeatherForecastWidget({
    super.key,
    required this.lstWeather,
  });
  final List<Weather> lstWeather;

  @override
  State<WeatherForecastWidget> createState() => _WeatherForecastWidgetState();
}

class _WeatherForecastWidgetState extends State<WeatherForecastWidget> {
  final List<DateTime> timeToday = [];

  @override
  void initState() {
    fetchWeatherToday();
    super.initState();
  }

  fetchWeatherToday() {
    timeToday.clear();
    int dateNow = DateTime.now().day;
    int date;
    if (widget.lstWeather.isNotEmpty) {
      for (var i in widget.lstWeather) {
        date = i.date!.day;

        if (date == dateNow) {
          timeToday.add(i.date!);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today',
                style: AppCommon.appTextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            WeeklyForecast(lstWeather: widget.lstWeather),
                      ));
                },
                child: Text(
                  'Weekly forecast',
                  style: AppCommon.appTextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: timeToday.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final item = widget.lstWeather[index];

              return Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Column(
                  children: [
                    ImageHelper.getImage(
                        height: 80,
                        folderName: ImagePath.images,
                        iconName: AppConstant.getImageWeatherType(
                            item.weatherConditionCode ?? 0)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${(item.temperature?.celsius)?.round()}°C',
                      style: AppCommon.appTextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      DateFormat('HH a').format(item.date ?? DateTime.now()),
                      style: AppCommon.appTextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
