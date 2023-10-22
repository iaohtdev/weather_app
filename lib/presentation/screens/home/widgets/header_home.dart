import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/constant.dart';
import 'package:weather_app/presentation/cubit/search/search_cubit_cubit.dart';
import 'package:weather_app/presentation/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app/presentation/screens/search/search_screen.dart';
import 'package:weather_app/shared/common.dart';
import 'package:weather_app/shared/helper/image_helper.dart';
import 'package:weather_app/shared/helper/log_helper.dart';

class HeaderHomeWidget extends StatelessWidget {
  const HeaderHomeWidget({
    super.key,
    required this.weather,
  });
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      color: AppConstant.primaryColor,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        weather.areaName ?? '',
                        style: AppCommon.appTextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        DateFormat('E, d MMM HH:mm a')
                            .format(weather.date ?? DateTime.now()),
                        style: AppCommon.appTextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 5,
                  child: InkWell(
                    onTap: () async {
                      Weather result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => SearchCubit(),
                              child: const SearchPlaceScreen(),
                            ),
                          ));

                      LogHelper.info(result);
                      context.read<WeatherCubit>().fetchWeather(
                          lat: result.latitude, long: result.longitude);
                    },
                    child: ImageHelper.getImage(
                        width: 25,
                        folderName: ImagePath.icons,
                        color: Colors.white,
                        iconName: ImageName.iconSearch),
                  ),
                )
              ],
            ),
          ),
          ImageHelper.getImage(
              width: 150,
              folderName: ImagePath.images,
              iconName: AppConstant.getImageWeatherType(
                  weather.weatherConditionCode ?? 0)),
          Text(
            '${(weather.temperature?.celsius)?.round()}°C',
            style: AppCommon.appTextStyle(
                color: Colors.white, fontSize: 70, fontWeight: FontWeight.bold),
          ),
          Text(
            weather.weatherMain ?? '',
            style: AppCommon.appTextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 90,
          )
        ],
      ),
    );
  }
}
