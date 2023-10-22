import 'package:flutter/material.dart';
import 'package:weather_app/shared/helper/image_helper.dart';

class AppConstant {
  //key
  // ignore: non_constant_identifier_names
  static String OPEN_WEATHER_KEY = 'bd5e378503939ddaee76f12ad7a97608';

  static Color primaryColor = const Color(0xff4ABADD);

  static String getImageWeatherType(int code) {
    switch (code) {
      case >= 200 && < 300:
        return ImageName.image1;
      case >= 300 && < 400:
        return ImageName.image2;
      case >= 500 && < 600:
        return ImageName.image3;
      case >= 600 && < 700:
        return ImageName.image4;
      case >= 700 && < 800:
        return ImageName.image5;
      case == 800:
        return ImageName.image6;
      case > 800 && <= 804:
        return ImageName.image7;
      default:
        return ImageName.image7;
    }
  }
}
