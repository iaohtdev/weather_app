import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/constant.dart';
import 'package:weather_app/shared/common.dart';
import 'package:weather_app/shared/helper/image_helper.dart';

class WeeklyForecast extends StatefulWidget {
  const WeeklyForecast({super.key, required this.lstWeather});
  final List<Weather> lstWeather;

  @override
  State<WeeklyForecast> createState() => _WeeklyForecastState();
}

class _WeeklyForecastState extends State<WeeklyForecast> {
  @override
  void initState() {
    fetchForecast();
    super.initState();
  }

  List<Weather> lst = [];
  fetchForecast() {
    int dateNow = DateTime.now().day;
    int date;
    if (widget.lstWeather.isNotEmpty) {
      for (var i in widget.lstWeather) {
        date = i.date!.day;

        if (date != dateNow) {
          if (!lst.any((element) => element.date!.day == date)) {
            lst.add(i);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppConstant.primaryColor,
        title: Text(
          widget.lstWeather[0].areaName ?? '',
          style: AppCommon.appTextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppConstant.primaryColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Next few days',
                  style: AppCommon.appTextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                ...lst.map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('E, d MMM')
                                .format(e.date ?? DateTime.now()),
                            style: AppCommon.appTextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          Row(
                            children: [
                              ImageHelper.getImage(
                                  height: 50,
                                  folderName: ImagePath.images,
                                  iconName: AppConstant.getImageWeatherType(
                                      e.weatherConditionCode ?? 0)),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                '${e.temperature?.celsius?.round()}°C',
                                style: AppCommon.appTextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
