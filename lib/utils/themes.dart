import 'package:flutter/material.dart';
import 'package:task_3/utils/dark_app_colors.dart';
import 'package:task_3/utils/dark_text_styles.dart';
import 'package:task_3/utils/light_app_colors.dart';
import 'package:task_3/utils/light_text_styles.dart';

abstract class Themes {
  static bool isLight = true;
  static final cityText = isLight ? LightTextStyles.cityText : DarkTextStyles.cityText;
  static final mainTempText = isLight ? LightTextStyles.mainTempText : DarkTextStyles.mainTempText;
  static final infoTemp = isLight ? LightTextStyles.infoTemp : DarkTextStyles.infoTemp;
  static final infoDetail = isLight ? LightTextStyles.infoDetail : DarkTextStyles.infoDetail;
  static final detailsTemp = isLight ? LightTextStyles.detailsTemp : DarkTextStyles.detailsTemp;
  static final cityDetailsText = isLight ? LightTextStyles.cityDetailsText : DarkTextStyles.cityDetailsText;
  static final formattedDateText = isLight ? LightTextStyles.formattedDateText : DarkTextStyles.formattedDateText;
  static final formattedTimeText = isLight ? LightTextStyles.formattedTimeText : DarkTextStyles.formattedTimeText;
  static final feelsLikeText = isLight ? LightTextStyles.feelsLikeText : DarkTextStyles.feelsLikeText;
  static final detailsWeatherText = isLight ? LightTextStyles.detailsWeatherText : DarkTextStyles.detailsWeatherText;
  static final detailsWindText = isLight ? LightTextStyles.detailsWindText : DarkTextStyles.detailsWindText;
  static final detailsHumidityText = isLight ? LightTextStyles.detailsHumidityText : DarkTextStyles.detailsHumidityText;
  static final moreIcon = isLight ? LightAppColors.moreIcon : DarkAppColors.moreIcon;
}