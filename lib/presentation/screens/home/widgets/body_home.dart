import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/shared/common.dart';
import 'package:weather_app/shared/helper/image_helper.dart';

class BodyHomeWidget extends StatelessWidget {
  const BodyHomeWidget({super.key, required this.weather});
  final Weather weather;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(),
          Positioned(
            top: -90,
            left: 30,
            right: 30,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: 300,
              decoration: BoxDecoration(
                  color: const Color(0xffE5F8FF),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: _item(
                            image: ImageName.image11,
                            title: 'Sunrise',
                            value: DateFormat('HH:mm a')
                                .format(weather.sunrise ?? DateTime.now())),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: _item(
                            image: ImageName.image12,
                            title: 'Sunset',
                            value: DateFormat('HH:mm a')
                                .format(weather.sunset ?? DateTime.now())),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: _item(
                            image: ImageName.image13,
                            title: 'Temp max',
                            value: '${weather.tempMax?.celsius?.round()}°C'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: _item(
                            image: ImageName.image14,
                            title: 'Temp min',
                            value: '${weather.tempMin?.celsius?.round()}°C'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _item(
      {required String image, required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageHelper.getImage(
            height: 50, folderName: ImagePath.images, iconName: image),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppCommon.appTextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              value.toLowerCase(),
              style: AppCommon.appTextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }
}
