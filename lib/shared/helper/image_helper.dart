import 'package:flutter/material.dart';

class ImageHelper {
  static String getPngPath(String folderName, String iconName,
      {String format = 'png'}) {
    return 'assets/$folderName/$iconName.$format';
  }

  static Widget getImage({
    required String folderName,
    required String iconName,
    double? width,
    double? height,
    Color? color,
  }) {
    return Image.asset(
      getPngPath(folderName, iconName),
      fit: BoxFit.cover,
      width: width,
      height: height,
      color: color,
    );
  }
}

abstract class ImagePath {
  //folder
  static String icons = 'icons';
  static String images = 'images';
}

abstract class ImageName {
  //icon
  static String iconSearch = 'icon_search';
  static String iconHumidity = 'icon_humidity';
  static String iconWind = 'icon_wind';

  //image
  static String image1 = '1';
  static String image2 = '2';
  static String image3 = '3';
  static String image4 = '4';
  static String image5 = '5';
  static String image6 = '6';
  static String image7 = '7';
  static String image8 = '8';
  static String image9 = '9';
  static String image10 = '10';
  static String image11 = '11';
  static String image12 = '12';
  static String image13 = '13';
  static String image14 = '14';
}
