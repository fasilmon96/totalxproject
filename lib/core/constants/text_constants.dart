import 'package:flutter/cupertino.dart';
import '../constants/color_constants.dart';

class AppTextStyles {
  static const mainHeading = TextStyle(
     fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.headingText
  );
  static const title = TextStyle(
     fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.black
  );
  static const subTitle = TextStyle(
     fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary
  );
  static const caption = TextStyle(
     fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary
  );

}